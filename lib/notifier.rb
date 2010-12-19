require 'registration'

module CentralNotifications
  class Notifier
    attr_accessor :registrations, :klass, :method
  
    def initialize args={}
      @registrations = {}
    end
  
    def self.instance
      return @@instance ||= Notifier.new
    end
  
    def register
      registration = Registration.new(:notifier => self)
      yield registration, self

      registration = registration_from_stack(registration)
      registrations[registration] ||= []
      registrations[registration] << {:klass => klass, :method => method}
      registration.fork
    end
  
    def alert(registration)
      registrations[registration].each do |notified|
        ObjectSpace.each_object(notified[:klass]) do |object|
          object.send(:instance_variable_set, :@registration_result, registration.result)
          object.send(notified[:method])
        end
      end
    end
  
    private
  
    def registration_from_stack registration
      reg = registrations.select {|registered, | registered.klass == registration.klass && registered.method == registration.method}
      reg.empty? ? registration : reg.first.first 
    end

  end
end