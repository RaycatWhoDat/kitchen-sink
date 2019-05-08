const accountTypes = [];

// These are the categories I plan on displaying.
const accountCategories = [
  'Investment',
  'Cash',
  'Property',
  'Credit Card',
  'Loan'
];

const accountIdsByType = accountTypes.reduce((_accountIdsByType, account) => {
  // Destructure the current account;
  const { accountClass, accountTypeId } = account;
  // Ensure that the current category is valid. If not, set it to 'Uncategorized'.
  const currentCategory = accountCategories.includes(accountClass) ? accountClass : 'Uncategorized';
  // If the category doesn't exist, let's make it an array.
  // Since we've checked the string already, it will be valid by this point.
  if (!_accountIdsByType[currentCategory]) _accountIdsByType[currentCategory] = [];
  // Push the account id to the array.
  _accountIdsByType[currentCategory].push(accountTypeId);
  // Since this is a reducer, return the accumulator.
  return _accountIdsByType;
}, {});
  
