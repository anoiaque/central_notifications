require 'central_notifications'
require 'models/order'

class User
  include CentralNotifications
 
  attr_accessor :new_amount
  
  def initialize args={}
  end
  
  def one_order_has_been_payed 
  end
  
  def all_orders_has_been_asked
  end
  
  def amount_has_changed
    @new_amount = @registration_result
  end
  
  register_for_notification do |registration, notification|
    registration.klass = Order
    registration.method = :payment
    notification.method = :one_order_has_been_payed
  end
  
  register_for_notification do |registration, notification|
    registration.klass = Order
    registration.method = :all
    notification.method = :all_orders_has_been_asked
  end
  
  register_for_notification do |registration, notification|
    registration.klass = Order
    registration.method = :amount=
    notification.method = :amount_has_changed
  end
  
end