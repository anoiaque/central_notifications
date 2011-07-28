# User use central notifications by including module, Accounting by initializer
require 'helper'
require 'models/central_notifications_initializer'

class TestNotifier < Test::Unit::TestCase
 
  def test_notifier_should_have_singleton_instance
    assert_equal CentralNotifications::Notifier.instance , CentralNotifications::Notifier.instance
  end
  
  def test_when_registered_method_is_called_method_triggered_of_registering_objects_should_be_called
    user, admin, order = User.new, User.new,  Order.new

    user.expects(:one_order_has_been_payed)
    admin.expects(:one_order_has_been_payed)
    
    order.payment(100, :usd)
  end 
  
  def test_should_call_orinal_method_with_original_parameters
    user, order = User.new, Order.new
    
    order.payment(100, :usd)

    assert_equal 100, order.amount
    assert_equal :usd, order.currency
  end
  
  def test_aliased_method_should_return_orginal_method_result
    assert_equal "payment done", Order.new.payment(100)
  end
  
  def test_notified_method_should_be_able_to_know_the_return_of_notfied_method
    user, order = User.new, Order.new
    
    result = order.payment(100, :usd)

    assert_equal result, user.instance_variable_get(:@registration_result)
  end
  
  def test_should_notify_class_method
    user = User.new
    
    user.expects(:all_orders_has_been_asked)
    Order.all
  end
  
  def test_should_be_able_to_act_as_observer_on_attributes_change
    user, order = User.new, Order.new
    
    user.expects(:amount_has_changed)
    order.amount = 200
    assert_equal 200, order.amount
  end
  
  def test_notifications_on_same_klass_method_for_many_objects_should_be_able
    user, accounting, order = User.new, Accounting.new, Order.new
    
    user.expects(:one_order_has_been_payed)
    accounting.expects(:one_order_has_been_payed)
    
    order.payment(100)
  end
  
  def test_notified_method_should_be_able_to_know_object_which_triggered_notifications
    user, order = User.new, Order.new
    
    result = order.payment(100, :usd)

    assert_equal order, user.instance_variable_get(:@notifier_object)
  end

end