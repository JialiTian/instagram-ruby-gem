module Instagram
  module Response
    def self.create( response_hash, ratelimit_hash )
      data = response_hash.data.dup rescue response_hash
      data.extend( self )
      data.instance_exec do
        %w{pagination meta}.each do |k|
          response_hash.public_send(k).tap do |v|
            instance_variable_set("@#{k}", v) if v
          end
        end
      end
      data['ratelimit'] = ::Hashie::Mash.new(ratelimit_hash)
      data
    end

    attr_reader :pagination
    attr_reader :meta
    attr_reader :ratelimit
  end
end
