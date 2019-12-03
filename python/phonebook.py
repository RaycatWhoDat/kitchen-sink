phonebook = lambda names, numbers: { name: number for name, number in zip(names, numbers) }
print(phonebook(["Tetsuo", "Kaneda"], ["another dimension", "555-THERAPY"]))

# Local Variables:
# compile-command: "python3 phonebook.py"
# End:
