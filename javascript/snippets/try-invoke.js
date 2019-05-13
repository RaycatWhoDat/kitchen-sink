function tryInvoke(target, functionName) {
    var allObjectPrototypes = {
	'Number': Number,
	'String': String,
	'Boolean': Boolean,
	'Object': Object,
	'Array': Array,
	'Date': Date,
	'Function': Function,
	'RegExp': RegExp
    };

    var currentType = '';
    var currentPrototypes = Object.keys(allObjectPrototypes)
	.reduce(function (_currentPrototypes, objectPrototypeName) {
	    var currentObjectPrototype = allObjectPrototypes[objectPrototypeName];
	    if (typeof target === objectPrototypeName.toLowerCase() || target instanceof currentObjectPrototype) {
		currentType = objectPrototypeName;
		_currentPrototypes = _currentPrototypes
		    .concat(Object.getOwnPropertyNames(currentObjectPrototype.prototype));
	    }
	    return _currentPrototypes;
	}, []);

    try {
	if (currentPrototypes.indexOf(functionName) < 0)
	    throw 'That function is not supported in this environment.';
	
	console.log('You can use this function in this environment.');
	return target[functionName](Array.prototype.slice.call(arguments, 2));
    } catch (error) {
	var errorMessage = [
	    'Tried to evoke',
	    functionName,
	    'on',
	    target != null ? target : '(indeterminate value)',
	    'which was an instance of',
	    target != null ? currentType : 'Undefined or Null'
	].join(' ');
	
	console.error('%s.', errorMessage);
    }

    return target;
}
