(function() {

    var testPerms = {
        testPerm1: true,
        testPerm2: false,
        testPerm3: true,
        testPerm4: false
    };

    var userPerms = {
        testPerm1: true,
        testPerm2: false,
        testPerm3: false,
        testPerm4: false
    };

    var allPermissions =  Object.keys(testPerms);
    var filePermissions = parseInt(allPermissions.reduce((acc, curr) => (testPerms[curr] ? '1' : '0').concat(acc), ''), 2);
    var userPermissions = parseInt(allPermissions.reduce((acc, curr) => (userPerms[curr] ? '1' : '0').concat(acc), ''), 2);

    var missingPermissions = userPermissions ^ filePermissions;
    var missingPermissionsString = (missingPermissions >>> 0).toString(2);
    var listOfMissingPermissions = allPermissions.reduce((acc, curr, index) => {
        var isMissingPermission = (missingPermissionsString[missingPermissionsString.length - (index + 1)] === '1');
        if (isMissingPermission) acc.push(curr);
        return acc;
    }, []);
    
    console.log('File permissions: ', filePermissions);
    console.log('User permissions: ', userPermissions);
    console.log('Permission check: ', filePermissions & userPermissions);
    console.log('Missing permissions: ', listOfMissingPermissions);
    
})();
