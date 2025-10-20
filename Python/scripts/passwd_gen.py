import random
pswd = []
lengthPasswd = int(input('Password length: ').strip())


## riempo la lista oltre alla lunghezza stabilita (poichè il loop andrà sempre oltre) 
while len(pswd) <= lengthPasswd:
    ## char maiuscoli
    MAIUSC = random.randint(65,90)
    pswd.append(chr(MAIUSC))
    ## char maiuscoli x2
    MAIUSC = random.randint(65,90)
    pswd.append(chr(MAIUSC))
    ## char minuscoli
    MINUSC = random.randint(97,122)
    pswd.append(chr(MINUSC))
    ## char minuscoli x2
    MINUSC = random.randint(97,122)
    pswd.append(chr(MINUSC))
    ## char speciali
    ##              33=!  36=$ 42=* 45=- 63=? 95=_
    specialChars = [ 33  , 36 ,  42 , 45 , 63, 95 ]
    SpecChar = random.choice(specialChars)
    pswd.append(chr(SpecChar))
    ## numeri convertiti a stringa
    number = random.randint(0,9)
    pswd.append(str(number))


## lista di char speciali convertita a stringa per il while sotto
actualSpecialChars = [chr(i) for i in specialChars]
## tronco la lunghezza della password con quella ricevuta in input
password = pswd[:lengthPasswd]
random.shuffle(password)


## check per non far iniziare la password con un char speciale
timesShuffled = 1
while password[0] in actualSpecialChars:
    random.shuffle(password)
    timesShuffled += 1


nLength = len(password)

## se l'array è stato mescolato, si aggiunge il numero di volte alla somma della potenza
if timesShuffled > 0:
    tot = timesShuffled + nLength
    nPossibilities = pow(68,tot)  
else:
    nPossibilities = pow(68,nLength)



## questa è una funzione che permette di inserire una virgola per le migliaia
## volendo si possono anche mettere i decimali: "{:,.2f}" .2f - decimali
formattednPossibilities = "{:,}".format(nPossibilities)


def read_number(number):
    # Define the numerical denominations
    denominations = ["", "thousand", "million", "billion", "trillion", "quadrillion", "quintillion", "sextillion", "septillion", "octillion", "nonillion", "decillion"]
    
    try:
        # Convert the number to a string and split it into groups of three digits
        number_str = str(number)[::-1]
        groups = [number_str[i:i+3][::-1] for i in range(0, len(number_str), 3)]
        
        # Build the string representing the number
        result = ""
        for i, group in enumerate(groups):
            if int(group) != 0:
                result = group + " " + denominations[i] + ", " + result
                
        # Remove the trailing comma and space
        result = result[:-2]
        ## se il numero è >= 19, diventa impossibile da leggere
    except IndexError:
        result = 'Impossible to read - over decillion'
        
    return result


actualNumber = read_number(nPossibilities)
#print(f"Password:\t{''.join(password)}\nLength:\t\t{nLength}\nTimes shuffled:\t{timesShuffled}\n___________________________________________________________________\n\nPossible pswd:\t{formattednPossibilities}\n{actualNumber}\n")

print(f"\nPassword:\t{''.join(password)}\nLength:\t\t{nLength}\nTimes shuffled:\t{timesShuffled}")