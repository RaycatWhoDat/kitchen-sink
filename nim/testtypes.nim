import strutils

type Color = enum
  Red
  Blue
  Green
  Silver
  Black

type Vehicle = ref object of RootObj
  name: string
  numberOfWheels: int

type Car = ref object of Vehicle
  color: Color

proc loseWheels(car: Car, wheelsToRemove: int) =
  car.numberOfWheels =
    if car.numberOfWheels - wheelsToRemove >= 0:
      car.numberOfWheels - wheelsToRemove
    else:
      0
                         
  if car.numberOfWheels < 1:
    echo "No more wheels!"
  elif car.numberOfWheels == 1:
    echo "There is 1 wheel remaining."
  else:
    echo "There are $# wheels remaining." % $(car.numberOfWheels)
    
var newCar = Car(name: "New Car", numberOfWheels: 4, color: Color.Red)

for wheelsToRemove in 1..<5:
  newCar.loseWheels(wheelsToRemove)

var testColor = Color.Black

var testMessage =
  case testColor:
    of Color.Red:
      "Red"
    of Color.Black:
      "Black"
    else:
      "No color."

echo testMessage
