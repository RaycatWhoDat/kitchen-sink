import macros
import sugar

macro zipShort(iterables: varargs[untyped]): untyped =
  result = quote do:
    var maximumLength = 999_999
    let zippedArray = collect(newSeq):
      for iterable in `iterables`:
        if maximumLength > iterable.len:
          maximumLength = iterable.len
          
      for index in 1 .. maximumLength:
        var currentTuple = ()
        for iterable in `iterables`:
          currentTuple += (iterable[index - 1])
        currentTuple

    zippedArray
            
when isMainModule:
  echo zipShort([1, 2], [3, 4], [5, 6])
            
