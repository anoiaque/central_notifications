specifications = Gem::Specification.new do |spec| 
  spec.name = "central_notifications"
  spec.version = "1.0.2"
  spec.author = "Philippe Cantin"
  spec.homepage = "http://github.com/anoiaque/central_notifications"
  spec.platform = Gem::Platform::RUBY
  spec.summary = "Register an object method for notifications"
  spec.description = %q{
   Based on the idea of notifications in objective-C.
   Register an object method for notifications.
   When registered method is called, all objects which have registered will be notified and
   will be able to know the result of the registered method.
   Can replace Rails observers.
  }
  spec.files = Dir['lib/**/*.rb']
  spec.require_path = "lib"
  spec.test_files  = Dir['test/**/*.rb']
  spec.has_rdoc = true
  spec.extra_rdoc_files = ["README.rdoc"]
  
end

 