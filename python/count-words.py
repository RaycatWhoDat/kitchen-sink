from collections import Counter

words = """
The foo the foo the
defenestration the
"""

print(Counter(" ".join(words.lower().strip().splitlines()).split(" ")))
