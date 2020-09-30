type User = object
  firstName: string
  lastName: string
  email: string

func getFullName(user: User): string =
  user.firstName & " " & user.lastName

func getEmail(user: User): string =
  user.email

var newUser = User(firstName: "New", lastName: "User", email: "newuser@gmail.com")

echo newUser.getFullName()
echo newUser.getEmail()
