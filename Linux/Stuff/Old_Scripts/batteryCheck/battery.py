
import os
import time

# scrittura file in caso di mancanza , errori ...
# firstFileWrite = os.system("bluetoothctl info > /home/federico/Nextcloud/Linux/Script/batteryCheck/battery.txt")


#           DEFINIZIONE FUNZIONI    


# apertura e pulizia della riga dove c'è la percentuale
def REcleanRead():

    # apro il txt, prendo l'ultima riga ed elimino gli spazi
     
    x = open("/home/federico/Documents/batteryCheckerScript/battery.txt", "r")

    for line in x.readlines(-1):
        y = line.strip()
    x.close()   

    # pulizia della riga considerata "Battery Percentage: 0x50 (80)"
    intCheck = (y[-4:]).strip("()")   
    return intCheck 
    




# se tutti i check vanno a buon fine aggiunge % e esce
def bttPrint():
    
    btt = intCheck +"%"
    print(btt)
    exit()

    
    
# riscrive il file per aggiornalo più spesso mentre il dispositivo non è connesso
def SecondFileWrite():
    
    SecondFileWrite  = os.system("bluetoothctl info > /home/federico/Documents/batteryCheckerScript/battery.txt")
                    
    return SecondFileWrite









#                         CODICE

# primo loop per caricare il file  e leggerlo

while True:
  
    intCheck = REcleanRead()

    # secondo loop per fare un check del type e stampare il risultato
    valueCheck = True
    while valueCheck:

        # se il dispositivo è connesso 
        try:
            btt = int(intCheck)
            
            # check del tipo
            
            if btt == int(intCheck):                     

                # check della batteria    
                
                # percentuale inconsistente / errata 
                if btt > 100 or btt <= 0:
                    SecondFileWrite()
                    REcleanRead()
                    valueCheck = False
                    break
                
                if btt <= 100 or btt > 0:
                    bttPrint()
   
                    
                    
                
                        
        # se il dispositivo non è connesso riparte il primo loop ogni 3 secondi, rileggendo il file finchè non verrà connesso
        except ValueError:
               
               # riscrive il file per aggiornalo più spesso mentre il dispositivo non è connesso
                SecondFileWrite()
                valueCheck = False
                time.sleep(3)





