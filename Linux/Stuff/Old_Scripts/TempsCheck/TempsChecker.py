
import os
import json

## fonti dati

### CPU e Nvme
### sensors -j > /home/federico/Documents/temps.json

### NVIDIA GPU
### nvidia-smi --query-gpu=temperature.gpu --format=csv,noheader

### SSD
### sudo smartctl -a /dev/sda2 | grep Temperature





###### CPU & Nvme #######

# apro il json
f = open("/home/federico/Documents/TempsCheck/temps.json")
data = json.load(f)
f.close()


# leggo la classe della cpu dal json e prendo la temp
# e arrotondo il valore in modo che abbia una posizione decimale che sia 0 o 0.5

CPU     = data["k10temp-pci-00c3"]["Tctl"]['temp1_input']
Nvme    = data["nvme-pci-0700"]["Composite"]["temp1_input"]






######### NVIDIA GPU #########


x = open("/home/federico/Documents/TempsCheck/nvidiaSMI.txt", "r")

for line in x.readlines():   
    GPU = line.strip()
x.close()   

GPU = int(GPU)


    

####### SSD #######

z = open("/home/federico/Documents/TempsCheck/nvidiaSMI.txt", "r")

for line in z.readlines():
    SSD = line.strip()
z.close()   

SSD = int(SSD)




## print finali
print(f"CPU:\t{round(CPU*2)/2}°")
print(f"GPU:\t{round(GPU*2)/2}°\n")
print(f"NVME:\t{round(Nvme*2)/2}°")
print(f"SSD:\t{round(SSD*2)/2}°")