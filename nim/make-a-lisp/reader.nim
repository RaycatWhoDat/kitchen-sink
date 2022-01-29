import re

var malRegex = re"""[\s,]*(~@|[\[\]{}()'`~^@]|"(?:\\.|[^\\"])*"?|;.*|[^\s\[\]{}('\"`,;)]*)"""

type Reader = object
  rawInput: string
  tokens: seq[string]
  position: Natural

proc peek(reader: var Reader): string =
  if len(reader.tokens) > 0:
    return reader.tokens[0]
  else:
    return ""
    
proc next(reader: var Reader): string =
  if reader.position <= reader.tokens.len:
    var token = reader.peek()
    inc reader.position
    token
  else:
    ""

proc readForm*(reader: var Reader): string =
  for token in reader.tokens:
    echo token
    
  reader.next()

proc tokenize*(input: string): Reader =
  var tokens: seq[string] = @[];
      
  for token in input.findAll(malRegex):
    tokens.add(token)
                                                                                
  Reader(rawInput: input, tokens: tokens, position: 0)  
