import sequtils
import sugar

proc `Z`(iterables: varargs[openArray[untyped]]) =
  var
    result = []
    maximumLength = min(iterables.map((iterable) => iterable.len))
  
  for index in 1 .. maximumLength:
    var currentTuple = ()
    for iterable in iterables:
      currentTuple += (iterable[index - 1])

    result.push(currentTuple)

when isMainModule:
  echo [1, 2, 3, 4] Z [1, 2, 3, 4]
