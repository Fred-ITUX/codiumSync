import psutil        
import subprocess
import re


def get_temperatures():
    try:
        output = subprocess.check_output("sensors", shell=True).decode()

        cpu_temp = None
        gpu_temp = None

        lines = output.splitlines()
        for i, line in enumerate(lines):
            # CPU Temperature
            if 'Tctl' in line:
                match = re.search(r'\+([\d.]+)°C', line)
                if match:
                    cpu_temp = match.group(1)
                    cpu_temp = int ( float( cpu_temp ) )

            # AMD GPU Temperature
            if 'amdgpu' in line.lower():
                for j in range(i+1, min(i+5, len(lines))):
                    if 'edge' in lines[j]: 
                        match = re.search(r'\+([\d.]+)°C', lines[j])
                        if match:
                            gpu_temp = match.group(1)
                            gpu_temp = int( float(gpu_temp) )
                            break


        return cpu_temp, gpu_temp
    except subprocess.CalledProcessError:
        return None, None, None




def get_gpu_usage():
    try:
        # Run radeontop with one update and parse output
        output = subprocess.check_output("radeontop -d - -l 1", shell=True).decode()
        match = re.search(r'gpu\s+(\d+\.\d+)%', output)
        if match:
            return float(match.group(1))
    except subprocess.CalledProcessError:
        return None
    return None



def get_gpu_and_vram_usage(total_vram_gb=8):  # <-- pass total VRAM in GB here
    try:
        output = subprocess.check_output("radeontop -d - -l 1", shell=True).decode()
        gpu_match = re.search(r'gpu\s+(\d+\.\d+)%', output)
        vram_match = re.search(r'vram\s+(\d+\.\d+)%', output)  

        gpu_usage = float(gpu_match.group(1)) if gpu_match else None

        if vram_match:
            vram_percent = float(vram_match.group(1))
            vram_used_gb = (vram_percent / 100.0) * total_vram_gb
        else:
            vram_used_gb = None

        return gpu_usage, vram_used_gb

    except subprocess.CalledProcessError:
        return None, None





#### CPU Usage
cpu_usage = psutil.cpu_percent(interval=1)

#### GPU Usage & VRAM
gpu_usage, vram_used_gb = get_gpu_and_vram_usage()

#### Temperatures
cpu_temp, gpu_temp = get_temperatures() 

#### RAM
memory_info = psutil.virtual_memory()

ram_used = memory_info.used / (1024 ** 3)
# ram_used = int ( float( ram_used ) )


#### Swap
swap_info = psutil.swap_memory()

swap_used = swap_info.used / (1024 ** 3)
# swap_used = int ( float (swap_used) )


print(f" 🧠 {cpu_usage:.0f}% 🌡️{cpu_temp}° 🖥️ {gpu_usage:.0f}%  📺 {vram_used_gb:.1f}GB 🌡️{gpu_temp}° 💾{ram_used:.1f}GB  🔄{swap_used:.1f}GB") 


if gpu_temp >= 60:
    script="home/federico/Nextcloud/Linux/scripts/Shortcuts/GPU_fan_speed/gpu_fan_speed"
    subprocess.run([f'/{script}_100.sh'] , capture_output=True, text=True)