import psutil        # System and process utilities
import subprocess
import re


def get_temperatures():
    try:
        output = subprocess.check_output("sensors", shell=True).decode()
        cpu_temp = None

        lines = output.splitlines()
        for line in lines:
            if 'Package id 0' in line:
                match = re.search(r'\+([\d.]+)°C', line)
                if match:
                    cpu_temp = int(float(match.group(1)))
                    break  # No need to keep scanning once found

        return cpu_temp
    except subprocess.CalledProcessError:
        return None







#### CPU Usage
cpu_usage = psutil.cpu_percent(interval=1)


#### Temperatures
cpu_temp = get_temperatures()

#### RAM
memory_info = psutil.virtual_memory()

ram_used = memory_info.used / (1024 ** 3)
# ram_used = int ( float( ram_used ) )


#### Swap
swap_info = psutil.swap_memory()

swap_used = swap_info.used / (1024 ** 3)
# swap_used = int ( float (swap_used) )



#### Visualization
print(f"🧠 {cpu_usage:.0f}%🌡️{cpu_temp}° 💾 {ram_used:.1f}GB  🔄 {swap_used:.1f}GB") 




#### Visualization
#print(f"🧠{cpu_usage}%🌡️{cpu_temp}°  🖥️{gpu_usage}%🌡️{gpu_temp}° 💾{memory_info.used / (1024 ** 3):.2f}GB 🔄 {swap_info.used / (1024 ** 3):.2f}GB") 









##################################################################
##################################################################
##################################################################
##################################################################

# import psutil   # System and process utilities
# import subprocess  
# import re 

# def get_temperatures():
    
#     #### Data from 'sensors' command
#     try:
#         output = subprocess.check_output("sensors", shell=True).decode()
        
#         #### Parsing for CPU and GPU temperature lines
#         temp_data = re.findall(r'(\w+):\s+\+?([\d.]+)°C', output)
#         cpu_temp = None

#         for sensor, temp in temp_data:
            
#             #### Tctl is the correct sensor for the CPU -- temp3 (CPU from motherboard) or edge (specific for the GPU)
#             if sensor == 'Tctl': 
#                 cpu_temp = f"{ int(  float(temp) ) }"
#                 break

#             # AMD GPU Temperature
#             if 'amdgpu' in line.lower():
#                 for j in range(i+1, min(i+5, len(lines))):
#                     if 'edge' in lines[j]:  # You could also check 'junction' if supported
#                         match = re.search(r'\+([\d.]+)°C', lines[j])
#                         if match:
#                             gpu_temp = match.group(1)
#                             break

#         return cpu_temp , gpu_temp
#     except subprocess.CalledProcessError as e:
#         return None



# #### CPU
# cpu_usage = psutil.cpu_percent(interval=1)
# cpu_temp = get_temperatures()

# #### RAM
# memory_info = psutil.virtual_memory()

# #### Swap
# swap_info = psutil.swap_memory()

# #### GPU 📺
# gpu_usage = ""
# gpu_temp = get_temperatures()
# # gpu_temp  = ""

# #### Visualization
# print(f"🖥️ {cpu_usage}% 🌡️{cpu_temp}° GPU {gpu_temp}° 💾 {memory_info.used / (1024 ** 3):.2f}GB  🔄 {swap_info.used / (1024 ** 3):.2f}GB")
