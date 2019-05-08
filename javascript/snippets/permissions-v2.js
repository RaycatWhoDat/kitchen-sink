var allPermissions = [
    'MODIFY_USERS',
    'MODIFY_MODELS',
    'MODIFY_PORTFOLIOS',
    'MODIFY_ADVISORS',
    'MODIFY_DATABASES'                
];

var user = {
    name: "Test User 1",
    permissionLevel: 24,
    hasPermission: function(permissionName) {
        var selectedPermission = 1 << allPermissions.indexOf(permissionName);
        return (this.permissionLevel & selectedPermission) === selectedPermission;
    }
};

console.log(user.hasPermission('MODIFY_USERS'));
console.log(user.hasPermission('MODIFY_ADVISORS'));
console.log(user.hasPermission('MODIFY_DATABASES'));
