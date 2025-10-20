import subprocess
import re

def get_ssd_temperature():
    try:
        # Run smartctl command and capture output
        smartctl_output = subprocess.check_output("sudo smartctl -A /dev/sda", shell=True).decode()
        
        
        # Adjusted regex to extract temperature correctly
        match = re.search(r"194\s+Temperature_Celsius\s+\S+\s+\S+\s+\S+\s+\S+\s+\S+\s+\S+\s+-\s+(\d+)", smartctl_output)

        return int(match.group(1)) if match else None

    except subprocess.CalledProcessError as e:
        print("Error running smartctl:", e)
        return None

# Get SSD temperature
ssd_temp = get_ssd_temperature()

# Print result
print(f"📀 {ssd_temp}°")

