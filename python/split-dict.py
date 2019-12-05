result = {}
for line in open("split-dict-input.txt", "r"):
    current_line = line.replace("\n", "").split(",")
    first, rest = current_line[0], current_line[1:]
    result[first] = tuple(rest)

print(result)

# Local Variables:
# compile-command: "python3 split-dict.py"
# End:

