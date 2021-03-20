# class BankAccount
#   attr_reader :balance

#   def initialize(account_number, client)
#     @account_number = account_number
#     @client = client
#     @balance = 0
#   end

#   def deposit(amount)
#     if amount > 0
#       self.balance += amount
#       "$#{amount} deposited. Total balance is $#{balance}."
#     else
#       "Invalid. Enter a positive amount."
#     end
#   end

#   def withdraw(amount)
#     if (balance - amount) > 0
#       success = (self.balance -= amount)
#     else
#       success = false
#     end

#     if success
#       "$#{amount} withdrawn. Total balance is $#{balance}."
#     else
#       "Invalid. Enter positive amount less than or equal to current balance ($#{balance})."
#     end
#   end

#   def balance=(new_balance)
#     if valid_transaction?(new_balance)
#       @balance = new_balance
#       true
#     else
#       false
#     end
#   end

#   def valid_transaction?(new_balance)
#     new_balance >= 0
#   end
# end

# # Example

# account = BankAccount.new('5538898', 'Genevieve')

#                           # Expected output:
# p account.balance         # => 0
# p account.deposit(50)     # => $50 deposited. Total balance is $50.
# p account.balance         # => 50
# p account.withdraw(80)    # => Invalid. Enter positive amount less than or equal to current balance ($50).
# p account.balance         # => 50

# BankAccount class with overdraft protection. Get unexpected output. why? make changes.
# Changed #withdraw. Check if balance - amount was > 0 with 'if'. If false, success = (self.balance -=
# amount) is not executed.  
# Not correct. a negative number passed in would result in addition (50 - -80) = 130 not correct.

# LS: 

class BankAccount
  attr_reader :balance, :test

  def initialize(account_number, client)
    @account_number = account_number
    @client = client
    @balance = 0
  end

  def deposit(amount)
    if amount > 0
      self.balance += amount
      "$#{amount} deposited. Total balance is $#{balance}."
    else
      "Invalid. Enter a positive amount."
    end
  end

  def withdraw(amount)
    if amount > 0 && valid_transaction?(balance - amount)
      self.balance -= amount
      "$#{amount} withdrawn. Total balance is $#{balance}."
    else
      "Invalid. Enter positive amount less than or equal to current balance ($#{balance})."
    end
  end

  def balance=(new_balance)
      @balance = new_balance
  end

  def test=(test)
    test << 'ing'
    @test = test
  end

  def valid_transaction?(new_balance)
    new_balance >= 0
  end
end

# Example

account = BankAccount.new('5538898', 'Genevieve')

                          # Expected output:
p account.balance         # => 0
p account.deposit(50)     # => $50 deposited. Total balance is $50.
p account.balance         # => 50
p account.withdraw(80)    # => Invalid. Enter positive amount less than or equal to current balance ($50).
p account.balance         # => 50

# In Ruby, setter method ALWAYS returns the argument that was passed in, even when you add an explicit
# return statement. Our balance= method will therefore always return its argument, irrespective of
# whether or not the instance variable @balance is re-assigned.
# Because of this behavior, the invocation of balance= on line 21 of the original code will have a 
# truthy return value even when our setter method does not re-assign @balance; it will never return
# false.
# A better solution is to check the validity fo the transaction by calling valid_transaction?
# in #withdraw instead of balance=.  If the transaction is deemed valid, we then invoke balance=,
# otherwise we don't.  This way we don't attempt to use the setter for its return value, but instead
# let it do its one job; assigning a value to @balance.
# FE: What will the return value of a setter method be if you mutate its argument in the method body?

account.test = 'runn'
p account.test# 'running' returns the mutated argument.
