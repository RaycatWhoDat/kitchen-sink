def add1(number):
    return number + 1

def subtract2(number):
    return number - 2

def multiply3(number):
    return number * 3

def divide4(number):
    return number / 4

def createPipeline(ops):
    def _pipeline(number):
        result = number
        for operation in ops:
            result = operation(result)
        return result
    return _pipeline

pipeline = createPipeline([add1, subtract2, multiply3, divide4])

for result in map(pipeline, range(1, 6)):
    print(result)
