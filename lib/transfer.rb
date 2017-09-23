require 'pry'

class Transfer
attr_accessor :sender, :receiver, :status
attr_reader :amount

  def initialize(sender, receiver, amount)
    @sender = sender
    @receiver = receiver
    @amount = amount
    @status = "pending"
    @previous_amount = 0
  end

  def valid?
    @sender.valid? && @receiver.valid?
  end

  def execute_transaction
    if @sender.valid? && @sender.balance > @amount
      sender.balance -= @amount
      receiver.balance += @amount
      @previous_amount = @amount
      @amount = 0
      @status = "complete"
    else
      @status = "rejected"
      "Transaction rejected. Please check your account balance."
    end
  end

  def reverse_transfer #this is ugly and i dont like it.
    @sender, @receiver = @receiver, @sender #swap sender and receiver
    @amount = @previous_amount #reset amount from 0 to previous
    self.execute_transaction
    @status = "reversed"
    # I wanted to make reverse_transfer(sender, recevier, amount), and for each transfer, add it to a class variable holding all transfers,
    # and then check to see if the reverse transfer request matched a previous transfer, and swap sender and receiver if so, but it wants
    # 0 arguments :(

  end
end
