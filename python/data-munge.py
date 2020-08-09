import csv

with open("MOCK_DATA.csv") as csvFile:
    for row in csvFile:
        print(row)
