var roles = [
    'ROLE_SUPER_ADMIN',
    'ROLE_ADMIN',
    'ROLE_ADVISER',
    'ROLE_CLIENT',
    'ROLE_PROSPECT',
    'ROLE_OTHER',
    'DO_NOT_IMPORT'
];

var userRoles = [
    'ROLE_ADMIN'
];

var currentRole = userRoles[0]
    .split('_')
    .map(roleFragment => roleFragment[0] + roleFragment.substr(1).toLowerCase()).join('');
   
console.log(currentRole);
