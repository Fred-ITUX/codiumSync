
def style(toFormat):

    LtoFormat = 0
    LtoFormat = len(toFormat)

    nDash = 7
    rowDash = ['+','-'*nDash]

    rowDash.append(f"{'-'*LtoFormat}{'-'*nDash}+")
    finalRowDash = ''.join(rowDash)

    print('\necho "\n\n\n\n')

    ##### uno spazio per il '+', più tanti spazi quanti '-'
    print(finalRowDash , f'\n\n {" "*nDash}{toFormat}\n\n{finalRowDash}' )

    print('\n\n\n\n"')





##### Formattazione per newPc_Install script

stringInput  = input().strip().upper()


start = style(f"START INSTALL {stringInput}") 
print(f"# \nsudo apt install {stringInput.lower()} -y", end='')
end   = style(f"END   INSTALL {stringInput}") 



