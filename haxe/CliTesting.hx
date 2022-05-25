package;

typedef User = {
 ?firstName: String,
 ?lastName: String,
 ?middleName: String,
 ?userName: String
};

function main() {
  var newUser: User = {};
  Sys.println("What is your first name?");
  var numberString: String = "";
  while (Std.parseInt(numberString) == null) { numberString = Sys.stdin().readLine(); }
  Sys.println(Std.parseInt(numberString));
}


  