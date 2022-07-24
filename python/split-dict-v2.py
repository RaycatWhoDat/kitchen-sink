import csv

newdict = {}
with open("./split-dict-input.txt") as csvfile:
    reader = csv.reader(csvfile, delimiter = ",")
    for [key, *values] in reader:
        newdict[key] = [value for value in values if len(value) > 0]

print(newdict)
