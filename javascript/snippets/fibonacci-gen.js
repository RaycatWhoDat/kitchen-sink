const fibonacciGenerator = function* () {
  let prev = 0;
  let curr = 1;
  let next = null;
  while (true) {
    next = prev + curr;
    yield prev;
    prev = curr;
    curr = next;
  }
}

const take = (genFun, limit = Number.MAX_SAFE_INTEGER) => {
  const results = [];
  for (; limit >= 0; limit--) {
    results.push(genFun.next().value);
  }
  return results;
}

const fibonacci = numberOfFibonacciNumbers => take(fibonacciGenerator(), numberOfFibonacciNumbers);

console.log(fibonacci(99));
