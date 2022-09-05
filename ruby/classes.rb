class Account
  @@number = 1
  attr_accessor :number, :balance

  def initialize balance
    @balance = balance || 0
    @number = @@number
    @@number += 1
  end

  def +(account)
    self.balance += account.balance
    account.balance = 0
  end
end

account1 = Account.new(20)
account2 = Account.new(40)

puts account1.inspect
puts account2.inspect

account1 + account2

puts account1.inspect
puts account2.inspect
