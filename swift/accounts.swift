struct Account {
    static var number = 0
    var balance: Int
    let accountNumber: Int

    init(balance: Int) {
        self.balance = balance
        Account.number += 1
        self.accountNumber = Account.number        
    }
}

func +(lhs: inout Account, rhs: inout Account) {
    lhs.balance += rhs.balance
    rhs.balance = 0
}

var account1 = Account(balance: 20)
var account2 = Account(balance: 40)

print(account1)
print(account2)

account1 + account2

print(account1)
print(account2)
