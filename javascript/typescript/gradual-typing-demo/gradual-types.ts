// testfile
interface ArrayWithLiteralsInterfacePrimitive {
  prop1: number
}

interface ArrayWithLiteralsInterfacePrimitive2 {
  prop1: string
}

interface ArrayWithLiteralsInterface extends ArrayWithLiteralsInterfacePrimitive, ArrayWithLiteralsInterfacePrimitive2 { }

type ArrayWithLiteralsType = ArrayWithLiteralsInterface & ArrayWithLiteralsInterfacePrimitive;

// type PropKeyName = 'prop1' | 'prop2' | 'prop3';

enum PropKeyName {
  PROP_1 = 'prop1',
  PROP_2 = 'prop2',
  PROP_3 = 'prop3'
}
// : Record<PropKeyName, number>[]

let test1 = 12334;
const testArray: Record<PropKeyName, string>[] = [
  { 'prop1': 1234 },
  { 'prop2': 1234 },
  { 'prop3': 1234 },
  { 'prop4': 1234 },
  { 'prop5': 1234 },
  { 'prop6': 1234 },
  { 'prop7': 1234 },
  { 'prop8': 1234 },
  { 'prop9': 1234 }
];
