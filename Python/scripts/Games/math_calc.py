import random

def advance(lvl):

    if lvl > 0 and lvl < 10:
        operators = [ '+', '-' ] 
        n1 = random.randint(0, 150)
        n2 = random.randint(0, 100)

    elif lvl >= 10 and lvl < 15:
        operators = [ '*' ] 
        n1 = random.randint(0, 50)
        n2 = random.randint(0, 25)

    elif lvl >= 15 and lvl < 20:
        operators = [ '/' ] 
        n1 = random.randint(0, 50)
        n2 = random.randint(5, 25)

    else:
        operators = [ '+', '-', '*', '/' ] 
        n1 = random.randint(0, 100)
        n2 = random.randint(0, 100)
        
    op = random.choice(operators)

    return op, n1 ,n2



def calc(op):

    try:
        if op == "+":
            result = n1+n2
        elif op == "-":
            result = n1-n2
        elif op == "/":
            result = n1/n2
            result = float(f'{result:.1f}')
        elif op == "*":
            result = n1*n2
        else:
            print(f'Operation error, exiting...')
            exit()
    except ZeroDivisionError:
            result = 0

    # print(f'result: {n1} {op} {n2} = {result}')
    return result



while True:

    lvl = 0

    while True:        
        
        lvl += 1
        op, n1, n2 = advance(lvl)
        result = calc(op)

        
        
        try:
            userInput = float(input(f'\nLevel: {lvl}\t {n1} {op} {n2} = '))
            userInput = float(f'{userInput:.1f}')
        except Exception as e:
            print(f'Error {e}, resetting...')
            break

        if userInput != float(result):
            print(f'\n❌ Wrong: {n1} {op} {n2} = {result}\n')
            
            again = input('\nTry again? y/n ')
            if again == "y":
                break
            else:
                exit()
