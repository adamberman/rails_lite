require 'uri'

module Phase5
  class Params
    # use your initialize to merge params from
    # 1. query string
    # 2. post body
    # 3. route params
    #
    # You haven't done routing yet; but assume route params will be
    # passed in as a hash to `Params.new` as below:
    def initialize(req, route_params = {})
      @params = {}
      @params.merge!(parse_www_encoded_form(req.query_string)) unless req.query_string.nil?
      @params.merge!(parse_www_encoded_form(req.body)) unless req.body.nil?
      @params.merge!(route_params)  
    end

    def [](key)
      @params[key.to_s]
    end

    def to_s
      @params.to_json
    end

    class AttributeNotFoundError < ArgumentError; end;

    private
    # this should return deeply nested hash
    # argument format
    # user[address][street]=main&user[address][zip]=89436
    # should return
    # { "user" => { "address" => { "street" => "main", "zip" => "89436" } } }
    def parse_www_encoded_form(www_encoded_form)
      params = {}
      URI.decode_www_form(www_encoded_form).each do |key_string, value|
        keys = parse_key(key_string)
        current = params
        keys.each do |key|
          unless key == keys.last
            current[key] ||= {}
            current = current[key]
          else
            current[key] = value
          end
        end
      end
      params
    end



    # this should return an array
    # user[address][street] should return ['user', 'address', 'street']
    def parse_key(key)
      if key.include?('[')
        key.split(/\]\[|\[|\]/)
      else
        [key]
      end
    end
  end
end
