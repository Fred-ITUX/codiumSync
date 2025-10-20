while true
    do 
    sensors -j > /home/federico/Documents/TempsCheck/temps.json
    nvidia-smi --query-gpu=temperature.gpu --format=csv,noheader  > /home/federico/Documents/TempsCheck/nvidiaSMI.txt
    sudo smartctl -a /dev/sda2 | grep Temperature  > /home/federico/Documents/TempsCheck/ssd.txt
    sleep 5s
    
done