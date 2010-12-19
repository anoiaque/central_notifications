CentralNotifications.notify do |registration, notification|
  registration.klass = Order
  registration.method = :payment
  notification.klass = Accounting
  notification.method = :one_order_has_been_payed
end

CentralNotifications.notify do |registration, notification|
  registration.klass = Order
  registration.method = :all
  notification.klass = Accounting
  notification.method = :all_orders_has_been_asked
end