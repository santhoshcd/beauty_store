require 'json_web_token'

class Services::Api::AuthController < ApplicationController
	before_action :check_access, except: [ :token ]

  def token
    username = params[:username]
    password = params[:password]

    if is_validate_auth(username, password)
      payload = {
        data: {
          username: username,
        }
      }
      
      token = JsonWebToken.encode payload        
      render json: {token: token}, status: :ok
    else 
      invalid_token_json_response
    end
  end

  private
    
    def api_service_username
      "test"  
    end
    
    def api_service_password
      "test@321"
    end

    def is_validate_auth(username, password)
        username == api_service_username && password == api_service_password
    end


    def check_access
      jwt_token = auth_header.split("Bearer ")[1]
      decoded_token = JsonWebToken.decode jwt_token
      @jwt_payload = decoded_token[0]
    rescue Exception => e 
      invalid_token_json_response
    end

    def auth_header
      request.headers["HTTP_AUTHORIZATION"]
    end

    def invalid_token_json_response
      render json: {
        errors: [{
            status: "401",
            code: "UNAUTHORIZED",
            source: { "pointer": "/api/v1/auth/token" },
            title:  "Authentication Failed - Invalid Token",
            detail: "Pass valid username and password to get JWT token"
          }
        ]
      }, status: 401
    end

end
