import strformat

type Person = ref object of RootObj
  name: string
  age: int

type Manager = ref object of Person
  role: string
  
var jim = Manager(name: "Jim", age: 53, role: if false: "Dude" else: "Duder")

echo fmt"{jim.name} is a {jim.role}"
