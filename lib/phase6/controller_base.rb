require_relative '../phase5/controller_base'

module Phase6
  class ControllerBase < Phase5::ControllerBase
    # use this with the router to call action_name (:index, :show, :create...)
    def invoke_action(name)
    	#call a method that we know the name of...
    	self.send(name)
    end

    def initialize(req, res, params = {})
    	if self.class.verify_token? && req.method == :post
    		self.class.protect_from_forgery
    	end
    	super
    end
  end
end
