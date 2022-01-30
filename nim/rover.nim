import strutils, unittest

type Grid = object
  width: int
  height: int
  
type Direction = enum
  North
  East
  South
  West

type Position = array[0..1, int]
type Heading = array[Direction, seq[int]]

const HEADINGS: Heading = [
  @[0, -1],
  @[1, 0],
  @[0, 1],
  @[-1, 0]
]
  
type Rover = ref object
  xCoordinate: int
  yCoordinate: int
  direction: Direction

proc makeGrid(width: int, height: int): Grid =
  Grid(width: width, height: height)
  
proc getCurrentPosition(rover: Rover): string =
  var position = [$rover.xCoordinate, $rover.yCoordinate, $rover.direction]
  echo "Currently at $# $# facing $#..." % position
  position.join(" ")

proc setStartingPosition(rover: Rover, grid: Grid, position: Position, direction: Direction) =
  if position[0] < 0 or position[0] > grid.width or position[1] < 0 or position[1] > grid.height:
    echo "Out of bounds. Defaulting to [1, 1]."
    rover.xCoordinate = 1
    rover.yCoordinate = 1
  else:
    rover.xCoordinate = position[0]
    rover.yCoordinate = position[1]

proc parseInstructions(rover: Rover, grid: Grid, instructions: string) =
  for character in instructions:
    case character:
      of 'M':
        echo "Moving forward..."
        var deltas = HEADINGS[rover.direction]
        var newXCoordinate = rover.xCoordinate + deltas[0]
        var newYCoordinate = rover.yCoordinate + deltas[1]
        rover.xCoordinate = if newXCoordinate > 0 and newXCoordinate <= grid.width: newXCoordinate else: rover.xCoordinate
        rover.yCoordinate = if newYCoordinate > 0 and newYCoordinate <= grid.height: newYCoordinate else: rover.yCoordinate
        
      of 'L':
        echo "Turning left..."
        rover.direction = if rover.direction == North: West else: pred(rover.direction)
        
      of 'R':
        echo "Turning right..."
        rover.direction = if rover.direction == West: North else: succ(rover.direction)
        
      else:
        discard

when isMainModule:
  suite "Rover should move around":
    setup:
      var grid = makeGrid(5, 5)
      var rover = Rover(xCoordinate: 0, yCoordinate: 0, direction: North)

    test "should parse instructions correctly 1":
      rover.setStartingPosition(grid, [1, 2], North)
      rover.parseInstructions(grid, "LMLMLMLMM")
        
      assert rover.getCurrentPosition() == "2 1 North"

    test "should parse instructions correctly 2":
      rover.setStartingPosition(grid, [3, 3], North)
      rover.parseInstructions(grid, "MMRMMRMRRM")
        
      assert rover.getCurrentPosition() == "5 1 North"
  
