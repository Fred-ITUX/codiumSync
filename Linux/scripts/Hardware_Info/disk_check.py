import subprocess  
import re         
import os


def check_disk(disk):

    checked = os.path.exists(disk)
            
    return checked

ssd500_exists = check_disk("/dev/sda")
ssd1TB_exists = check_disk("/dev/sdb")
hdd2tb_exists = check_disk("/dev/sdc1")


def get_temps():
    
    try:
        output = subprocess.check_output("sensors", shell=True).decode()

        #### NVMe
        temp_data = re.findall(r'(\w+[-\w]*):\s+\+?([\d.]+)\u00b0C', output)
        nvme_temps = []

        for sensor, temp in temp_data:
            if 'nvme' in sensor.lower() or 'composite' in sensor.lower():
                nvme_temps.append(int(float(temp)))

        

        try:
            ssd_temp  = None
            ssd_temp2 = None
            hdd2tb_temp = None

            if ssd500_exists:
                smartctl_output = subprocess.check_output("sudo smartctl -A /dev/sda", shell=True).decode()
                ssd_temp_match = re.search(r"Temperature_Celsius.*?(\d+)$", smartctl_output, re.MULTILINE)
                ssd_temp = int(ssd_temp_match.group(1)) if ssd_temp_match else None

            if ssd1TB_exists:
                smartctl_output2 = subprocess.check_output("sudo smartctl -A /dev/sdb", shell=True).decode()
                ssd_temp_match2 = re.search(r"Temperature_Celsius.*?(\d+)\s*\(Min/Max", smartctl_output2)
                ssd_temp2 = int(ssd_temp_match2.group(1)) if ssd_temp_match2 else None

            if hdd2tb_exists:
                hdd_smartctl_output = subprocess.check_output("sudo smartctl -A /dev/sdc1", shell=True).decode()
                hdd_temp_match = re.search(r"Temperature_Celsius.*?(\d+)\s*(?:\(|$)", hdd_smartctl_output)
                hdd2tb_temp = int(hdd_temp_match.group(1)) if hdd_temp_match else None

        except Exception as e:
            print("", e)
            ssd_temp    = None
            ssd_temp2   = None
            hdd2tb_temp = None


        return nvme_temps, ssd_temp , ssd_temp2, hdd2tb_temp

    except subprocess.CalledProcessError as e:
        return [], None




nvme_temps, ssd_temp, ssd_temp2 , hdd2tb_temp = get_temps()

if nvme_temps:
    # nvme = ", ".join([f"{temp}" for i, temp in enumerate(nvme_temps)])
    nvme = f"📀{nvme_temps[0]}°"
else:
    nvme= ""


if ssd_temp:
    ssd500 = f"💿{ssd_temp}°"
else:
    ssd500 = ""


if ssd_temp2:
    ssd1TB = f"💽{ssd_temp2}°"
else:
    ssd1TB = ""

if hdd2tb_temp:
    hdd2tb_temp = f"🗄️{hdd2tb_temp}°" ### 🖴📦 🗄️
else:
    hdd2tb_temp = ""


print(f"{nvme} {ssd1TB} {ssd500} {hdd2tb_temp}".replace("  "," ").strip())