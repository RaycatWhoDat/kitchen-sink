import reader

proc readStr(input: string): string =
  var reader = input.tokenize()
  reader.readForm()

proc printStr(output: string) =
  echo output
  
proc read: string =
  readStr(stdin.readLine())
  
proc eval(input: string): string =
  input
  
proc print(output: string) =
  printStr(output)
  
proc rep =
  while true:
    stdout.write("user> ")
    stdout.flushFile()
    print(eval(read()))
  
when isMainModule:
  rep()
