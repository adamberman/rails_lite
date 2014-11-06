require 'json'
require 'webrick'

module Phase4
  class Flash
    # find the cookie for this app
    # deserialize the cookie into a hash
    def initialize(req)
      message = req.cookies.select { |message| message.name == '_rails_lite_app' }.first
      if message
        @message = JSON.parse(message.value)
      else
        @message = {}
      end
    end

    def [](key)
      if @message[key].nil?
        return @message[key.to_sym]
        @message = nil
      else
        return @message[key]
        @message = nil
      end
    end

    def []=(key, val)
      @message[key] = val
    end

    # serialize the hash into json and save in a cookie
    # add to the responses cookies
    def store_flash(res)
      res.cookies << WEBrick::Cookie.new('_rails_lite_app', @message.to_json)
    end
  end
end
