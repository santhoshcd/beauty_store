require 'jwt'
class InvalidToken < StandardError; end

class JsonWebToken
  SECRET = Rails.application.secrets.secret_key_base
  JWT_TOKEN_EXPIRE_TIME = 2 # in hours

  class << self
    def encode(payload)
      payload[:exp] = JWT_TOKEN_EXPIRE_TIME.hours.from_now.to_i
      JWT.encode(payload, SECRET)
    end

    def decode(token)
      decoded_token = JWT.decode token, SECRET, true, { :algorithm => 'HS256' }
      body = decoded_token[0]
      HashWithIndifferentAccess.new body
    rescue => e
      raise InvalidToken
    end
  end
end