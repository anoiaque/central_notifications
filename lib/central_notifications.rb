require 'notifier'

module CentralNotifications
  
  def self.notify
    notifier = Notifier.instance
    notifier.register do |registration, notification|
      yield registration, notification
    end
  end
  
  def self.included(klass)
    class << klass
      def register_for_notification
        notifier = Notifier.instance
        notifier.register do |registration, notification|
          notification.klass = self
          yield registration, notification
        end
      end
    end
    
  end
end

