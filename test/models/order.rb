class Order
  attr_accessor :amount, :currency
  
  def initialize args={}
    
  end
  
  def payment amount, currency=:euro
    @amount = amount
    @currency = currency
    "payment done"
  end
  
  def self.all
    
  end
  
  
end