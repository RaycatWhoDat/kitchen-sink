package;

enum UserType {
  Guest;
  Customer;
  Admin;
}

@:structInit
class User {
  public var name: String;
  public var type: UserType;

  public function new(name: String, type: UserType) {
    this.name = name;
    this.type = type;
  }
}

class CSharpTesting {
  public static function main() {

    var testUser1: User = { name: "Adam", type: UserType.Guest };
    var testUser2: User = { name: "Ben", type: UserType.Customer };
    var testUser3: User = { name: "Charlie", type: UserType.Admin };
    
    for (user in [testUser1, testUser2, testUser3]) {
      Sys.println(user.name);
    }
  }
}