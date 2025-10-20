
def checkValue(prompt):

    while True:
        try:
            value = float(input(prompt).strip().replace(',', '.'))
            return value

        except ValueError:
            print("Not valid\n")

value = checkValue("N: ")
percentage = checkValue("%: ")

perc = (percentage * value) / 100

print(f"\n{perc:.2f} is {percentage}% of {value:.2f}")
print(f"|  {value:.2f} + {perc:.2f} = {value + perc:.2f}")
print(f"|  {value:.2f} - {perc:.2f} = {value - perc:.2f}")
