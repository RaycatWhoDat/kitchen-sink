var var1 = { prop1: 1234 };
var var2 = { prop1: 4321 };

function printProp1() {
    console.log(this.prop1);
}

printProp1.call(var2);
