package;

enum Id<T> {
  UserId(value: T);
  PostId(value: T);
}

function checkType<T>(value: Id<T>) {
  trace($type(value));
}

function main() {
  var testId = UserId(12);

  checkType(testId);
  
  trace("Testing.");
}