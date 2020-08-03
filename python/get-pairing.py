import itertools
import random

names = ["Syd", "Sabrina", "Veronica", "Sean", "Karan", "Ray"]
pairs = []

while len(set(names).difference(set(list(itertools.chain(*pairs))))) != 0:
    pairs = random.choices(list(itertools.combinations(names, 2)), k=3)

for (firstName, secondName) in pairs:
    print(f"{firstName} and {secondName}");
