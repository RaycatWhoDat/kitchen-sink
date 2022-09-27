import macros
import std/[sets, sequtils, sugar, tables]

type Direction = enum NORTH, EAST, SOUTH, WEST

var directions = @[
  Direction.NORTH,
  Direction.EAST,
  Direction.SOUTH,
  Direction.WEST
]

type Room = ref object
  numberOfRooms: int
  name: string
  description: string
  rooms: Table[Direction, Room]

method getExits(room: Room): seq[Direction] =
  collect:
    for direction in directions:
      if direction in room.rooms:
        direction

method getExplorables(room: Room): seq[Direction] =
  collect:
    for direction in directions:
      if direction notin room.rooms:
        direction
        
when isMainModule:
  var room1 = Room(
    name: "The Front Room",
    description: "The Front Room",
    rooms: initTable[Direction, Room]()
  )
  var room2 = Room(
    name: "The Back Room",
    description: "The Back Room",
    rooms: { SOUTH: room1 }.toTable
  )
  echo room1.getExits
  room1.rooms[NORTH] = room2
  echo room1.getExits
  echo room1.getExplorables
  
