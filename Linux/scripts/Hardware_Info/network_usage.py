# System and process utilities
import psutil 

# Allows you to run shell commands and capture their output or interact with them
import subprocess  
import re 
import time


# Get network stats at T1
net_io_1 = psutil.net_io_counters()

# timer + 1 from Executor
time.sleep(4) # allows us to calculate the network usage rate over a specific time interval. Without it, we wouldn't know how much data was sent or received per unit of time.

# Get network stats at T2
net_io_2 = psutil.net_io_counters()

# Calculate network usage in MB/s
bytes_sent_rate = (net_io_2.bytes_sent - net_io_1.bytes_sent) / (1024 ** 2)  # Convert bytes to MB
bytes_recv_rate = (net_io_2.bytes_recv - net_io_1.bytes_recv) / (1024 ** 2)  # Convert bytes to MB


# Formatting network
def format_rate(rate):
    if rate >= 1024:  # Use 1024 as the threshold for GB
        rate /= 1024
        return f"{rate:.1f}GB"
    else:
        return f"{rate:.1f}MB"

# Format rates
bytes_sent_rate = format_rate(bytes_sent_rate) 
bytes_recv_rate = format_rate(bytes_recv_rate) 

# print(f"📤{bytes_sent_rate}/s  📥{bytes_recv_rate}/s")
print(f"📤{bytes_sent_rate} 📥{bytes_recv_rate}")