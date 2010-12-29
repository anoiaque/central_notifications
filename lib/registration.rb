module CentralNotifications
  class Registration
    NOTIFIER_CLASS_VARIABLE = :@@_____notifier
    attr_accessor :klass, :method, :result
  
    def initialize(args={})
      @notifier = args[:notifier]
    end
  
    def fork
      @real_klass = singleton_method? ? (class << klass; self end) : klass 
      @original_alias_symbol = original_alias_symbol
      return if already_registered?
      set_notifier_in_notifier_class
      redefine_orinal_method
    end

    private
  
    def original_alias_symbol
      (method.to_s + '_original___#central_notifications_gem').to_sym
    end
  
    def already_registered?
      @real_klass.instance_methods.map(&:to_sym).include?(@original_alias_symbol)
    end
  
    def set_notifier_in_notifier_class
      @real_klass.send(:class_variable_set, NOTIFIER_CLASS_VARIABLE, @notifier)
    end
  
    def redefine_orinal_method
      original = @original_alias_symbol
      @real_klass.send(:alias_method, original, @method)
      redefine_method
    end
  
    def redefine_method
      registration, eigenclass, original = self, on_eigenclass?, @original_alias_symbol
      @real_klass.send(:define_method, @method) do |*params|
         registration.result = send(original, *params)
         notifier = (eigenclass ? self : self.class).send(:class_variable_get, NOTIFIER_CLASS_VARIABLE)
         notifier.alert(registration, self)
         registration.result
       end
    end
  
    def singleton_method?
      klass.send(:singleton_methods).map(&:to_sym).include?(@method)  
    end
  
    def on_eigenclass?
      @real_klass.ancestors.first != @real_klass
    end
  
  end
end  