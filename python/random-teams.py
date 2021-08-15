import random

names = ['RaycatWhoDat', 'Lythero', 'EmyFails', 'NosferatChew', 'DNOpls', 'DickDebonair', 'DahMuttDog', 'OverlordDyvone']

blue = random.sample(names, 4)
gold = [name for name in names if name not in blue]

for name in blue:
    print("Blue: ", name)

for name in gold:
    print("Gold: ", name)
