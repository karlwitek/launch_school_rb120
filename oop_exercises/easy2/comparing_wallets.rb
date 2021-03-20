# consider the following broken code: Modify so it works. Do not make the amount in the 
# wallet accessible to any method that isn't part of the wallet class.



class Wallet
  include Comparable

  def initialize(amount)
    @amount = amount
  end

  def <=>(other_wallet)
    amount <=> other_wallet.amount
  end

  protected

  attr_reader :amount
end

bills_wallet = Wallet.new(500)
pennys_wallet = Wallet.new(465)
if bills_wallet > pennys_wallet
  puts 'Bill has more money than Penny'
elsif bills_wallet < pennys_wallet
  puts 'Penny has more money than Bill'
else
  puts 'Bill and Penny have the same amount of money.'
end

# Bill has more money than Penny
# added protected with attr_reader below it..

# puts bills_wallet.amount#  error 'protected method, amount'

# LS :

# Easiest way would be to provide a public getter method for :amount.
# The problem description prevents this. Nobody should be able to look at the amount except
# another wallet. (object of same class). Use Module#protected method.  A protected method
# is similar to a private method, except that method of the class can call the protected
# method of any other object of the same class.  Thus, bills_wallet can look at pennys_wallet
# to find the amount.

# Module#protected ?? method from a module? built in?

# Further: This occurs frequently in applications.  Can you think of any applications where
# protected methods would be desirable?
# sensitive information ( bank account numbers, balances, important numbers, etc..)
# passwords..

