####        +--------------------------------------+ 
####        
####              PER LA RANDOMIZER DI POKEMÒN
####        
####        +--------------------------------------+

#### Yours -> Right    | Opponent -> Left
#### Yours -> Left     | Opponent -> Middle
#### Yours -> Middle   | Opponent -> Right

import random

direct = ['right','middle','left']

#### Randomize random
laps = random.randint(1,5)

for i in range(0,laps):
    choice = random.choice(direct)


L = 'left'
R = 'right'
M = 'middle'


#### Player's choice
print('  • Player ')
if choice =='right':
    print(f"\t{R} ❌❌✅")
elif choice == 'left':
    print(f"\t{L} ✅❌❌")
else:
    print(f"\t{M} ❌✅❌")


#### Opponent's choice
print('\n  • Opponent ')
if choice =='right':
    print(f"\t{L} ✅❌❌")
elif choice == 'left':
    print(f"\t{M} ❌✅❌")
else:
    print(f"\t{R} ❌❌✅")

