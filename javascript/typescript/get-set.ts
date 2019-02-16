enum FunctionMode {
    GET = 'GET',
    SET = 'SET'
}

const _et = (functionMode: FunctionMode, delimiter: string) => (trunk: any = null, leaves: string | string[] = [], defaultValue: any = null) => {
    if (!leaves) return trunk;
    if (!trunk) {
        if (functionMode === FunctionMode.GET) return defaultValue;
        if (functionMode === FunctionMode.SET) trunk = {};
    }

    const newRoot = Array.isArray(leaves) ? leaves : leaves.split(delimiter);
    const leafExists = (_: any, index: number, _leaves: any[]): any => {
        const possibleLeaf: any[] = _leaves.shift().split(delimiter);
        const actualLeaf: any = possibleLeaf.shift();

        if (possibleLeaf.length >= 1) _leaves.splice(index, 0, possibleLeaf);

        const leavesExist = () => trunk && index < _leaves.length;

        const leavesAndValuesExist = () =>
            trunk && trunk[actualLeaf] && index < _leaves.length;

        const getLeafValue = () =>
            trunk[actualLeaf] ? trunk[actualLeaf] : defaultValue;

        const setLeafValue = (newValue: any) => {
            trunk[actualLeaf] = JSON.parse(JSON.stringify(newValue));
            return newValue;
        };

        switch (functionMode) {
            case FunctionMode.GET:
                return leavesAndValuesExist()
                    ? _et(functionMode, delimiter)(trunk[actualLeaf], _leaves, defaultValue)
                    : getLeafValue();
            case FunctionMode.SET:
                if (!leavesExist()) return setLeafValue(defaultValue);
                trunk[actualLeaf] = {};
                return _et(functionMode, delimiter)(trunk[actualLeaf], _leaves, defaultValue);
        }
    };
    return newRoot.map(leafExists)[0];
}

// module.exports.get = 
// module.exports.set = _et(FunctionMode.SET, '.');

const _get = _et(FunctionMode.GET, '.');
const _set = _et(FunctionMode.SET, '.');

const testCase1 = {
    prop1: 1
};

const testCase2 = {
    prop1: 2,
    prop2: {
        prop3: 3
    }
};

const testCase3 = {
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
