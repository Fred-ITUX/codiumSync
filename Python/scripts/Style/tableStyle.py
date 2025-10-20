
##### Formattazione tabellare 
stringInput  = input().strip().upper()
LstringInput = len(stringInput)


####        + ------ +
####        | TYPE 1 |
####        + ------ +

print('\n\n+' , '-' *LstringInput, '+' , end='')
print('\n|' , stringInput, '|')
print('+' , '-' *LstringInput, '+\n\n' , end='')

print('\n')




####        +--------------------+ 
####        
####                TYPE 2
####        
####        +--------------------+



# nDash = 7
# rowDash = ['+','-'*nDash]

# rowDash.append(f"{'-'*LstringInput}{'-'*nDash}+")
# finalRowDash = ''.join(rowDash)

# print('\necho "\n')
# ##### uno spazio per il '+', più tanti spazi quanti '-'
# print(finalRowDash , f'\n\n {" "*nDash}{stringInput}\n\n{finalRowDash}' )
# print('\n"')






print('\n')


        ##############################
        ####                      ####
        ####        TYPE 3        ####
        ####                      ####
        ##############################


#### minimum -> nHash = 5
nHash = 12
rowHash = ['#'*nHash]
#### leading and trailing hashes
exHashes = '####'

rowHash.append(f"{'#'*LstringInput}{'#'*nHash}")

top_bot = ''.join(rowHash)

#### - {exHashes*2} per i exHashes hash all'inzio e alla fine
second_top_bot = f'{exHashes}{" "*( len(top_bot) - len(exHashes)*2 )}{exHashes}'

#### - len(exHashes) per i exHashes hash all'inzio
middle = f"{exHashes}{" "*( nHash - len(exHashes) )}{stringInput}{" "*( nHash - len(exHashes) )}{exHashes}"

print(f"{top_bot}\n{second_top_bot}\n{middle}\n{second_top_bot}\n{top_bot}")


print('\n')



####            %%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
####            %%%%        TYPE 5        %%%%
####            %%%%%%%%%%%%%%%%%%%%%%%%%%%%%%

#### minimum -> nPerc = 5
nPerc = 12
rowPerc = ['%'*nPerc]
#### leading and trailing hashes
exPerc = '%%%%'

rowPerc.append(f"{'%'*LstringInput}{'%'*nPerc}")

top_bot = ''.join(rowPerc)

#### - {exPerc*2} per i exPerc hash all'inzio e alla fine
second_top_bot = f'{exPerc}{" "*( len(top_bot) - len(exPerc)*2 )}{exPerc}'

#### - len(exPerc) per i exPerc hash all'inzio
middle = f"{exPerc}{" "*( nPerc - len(exPerc) )}{stringInput}{" "*( nPerc - len(exPerc) )}{exPerc}"

#print(f"{top_bot}\n{second_top_bot}\n{middle}\n{second_top_bot}\n{top_bot}")
print(f"{top_bot}\n{middle}\n{top_bot}")


print('\n')