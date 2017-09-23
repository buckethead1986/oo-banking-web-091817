# require 'pry'
#
# class Transfer
# attr_accessor :sender, :receiver, :status
# attr_reader :amount
#
#   def initialize(sender, receiver, amount)
#     @sender = sender
#     @receiver = receiver
#     @amount = amount
#     @status = "pending"
#     @previous_amount = 0
#   end
#
#   def valid?
#     @sender.valid? && @receiver.valid?
#   end
#
#   def execute_transaction
#     if @sender.valid? && @sender.balance > @amount
#       sender.balance -= @amount
#       receiver.balance += @amount
#       @previous_amount = @amount
#       @amount = 0
#       @status = "complete"
#     else
#       @status = "rejected"
#       "Transaction rejected. Please check your account balance."
#     end
#   end
#
#   def reverse_transfer #this is ugly and i dont like it
#     @sender, @receiver = @receiver, @sender #swap sender and receiver
#     @amount = @previous_amount #reset amount from 0 to previous
#     self.execute_transaction
#     @status = "reversed"
#     # I wanted to make reverse_transfer(sender, recevier, amount), and for each transfer, add it to a class variable holding all transfers,
#     # and then check to see if the reverse transfer request matched a previous transfer, and swap sender and receiver if so, but it wants
#     # 0 arguments :(
#
#   end
# end

#-----------Solution ----------
class Transfer
  attr_reader :amount, :sender, :receiver
  attr_accessor :status

  def initialize(sender, receiver, amount)
    @status = "pending"
    @sender = sender
    @receiver = receiver
    @amount = amount
  end

  def valid?
    sender.valid? && receiver.valid?
  end

  def execute_transaction
    if valid? && sender.balance > amount && self.status == "pending" #status is the check for only doing a trasaction once
      sender.balance -= amount #balance in Sender instance
      receiver.balance += amount
      self.status = "complete"
    else
      reject_transfer #own method. No need for extra code here
    end
  end

  def reverse_transfer
    if valid? && receiver.balance > amount && self.status == "complete" #checks everything is good to go, that a transfer happened.
      receiver.balance -= amount #reverse everything
      sender.balance += amount
      self.status = "reversed"
    else
      reject_transfer #syntactic sugar, no need to rewrite code.  make a method.
    end
  end

  def reject_transfer
    self.status = "rejected"
    "Transaction rejected. Please check your account balance."
  end
end
