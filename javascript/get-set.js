"use strict";
var FunctionMode;
(function (FunctionMode) {
    FunctionMode["GET"] = "GET";
    FunctionMode["SET"] = "SET";
})(FunctionMode || (FunctionMode = {}));
var _et = function (functionMode, delimiter) { return function (trunk, leaves, defaultValue) {
    if (trunk === void 0) { trunk = null; }
    if (leaves === void 0) { leaves = []; }
    if (defaultValue === void 0) { defaultValue = null; }
    if (!leaves)
        return trunk;
    if (!trunk) {
        if (functionMode === FunctionMode.GET)
            return defaultValue;
        if (functionMode === FunctionMode.SET)
            trunk = {};
    }
    var newRoot = Array.isArray(leaves) ? leaves : leaves.split(delimiter);
    var leafExists = function (_, index, _leaves) {
        var possibleLeaf = _leaves.shift().split(delimiter);
        var actualLeaf = possibleLeaf.shift();
        if (possibleLeaf.length >= 1)
            _leaves.splice(index, 0, possibleLeaf);
        var leavesExist = function () { return trunk && index < _leaves.length; };
        var leavesAndValuesExist = function () {
            return trunk && trunk[actualLeaf] && index < _leaves.length;
        };
        var getLeafValue = function () {
            return trunk[actualLeaf] ? trunk[actualLeaf] : defaultValue;
        };
        var setLeafValue = function (newValue) {
            trunk[actualLeaf] = JSON.parse(JSON.stringify(newValue));
            return newValue;
        };
        switch (functionMode) {
            case FunctionMode.GET:
                return leavesAndValuesExist()
                    ? _et(functionMode, delimiter)(trunk[actualLeaf], _leaves, defaultValue)
                    : getLeafValue();
            case FunctionMode.SET:
                if (!leavesExist())
                    return setLeafValue(defaultValue);
                trunk[actualLeaf] = {};
                return _et(functionMode, delimiter)(trunk[actualLeaf], _leaves, defaultValue);
        }
    };
    return newRoot.map(leafExists)[0];
}; };
// module.exports.get = 
// module.exports.set = _et(FunctionMode.SET, '.');
var _get = _et(FunctionMode.GET, '.');
var _set = _et(FunctionMode.SET, '.');
var testCase1 = {
    prop1: 1
};
var testCase2 = {
    prop1: 2,
    prop2: {
        prop3: 3
    }
};
var testCase3 = {
    prop1: 3,
    prop2: {
        prop3: 4,
        prop4: {
            prop5: 5
        }
    }
};
console.log('>> ', _get(testCase1, ['prop1']));
console.log('>> ', _get(testCase2, ['prop1', 'prop2']));
console.log('>> ', _set(testCase2, ['prop1', 'prop2'], 42));
console.log('>> ', _get(testCase2, ['prop1', 'prop2'], 31));
console.log('>> ', _get(testCase2, ['prop2', 'prop3']));
console.log('>> ', _get(testCase3, ['prop2', 'prop3']));
console.log('>> ', _get(testCase3, ['prop2', 'prop4']));
console.log('>> ', _get(testCase3, 'prop2.prop4.prop5'));
// Local Variables:
// compile-command: "tsc get-set.ts"
// End:
