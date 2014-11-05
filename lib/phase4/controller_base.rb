require_relative '../phase3/controller_base'
require_relative './session'
require_relative './flash'

module Phase4
  class ControllerBase < Phase3::ControllerBase
    def redirect_to(url)
    	session.store_session(super(url))
    end

    def render_content(content, type)
    	session.store_session(super(content, type))
    end

    # method exposing a `Session` object
    def session
    	@session ||= Session.new(req)
    end

    def flash
        @flash ||= Flash.new(req)
    end
  end
end
