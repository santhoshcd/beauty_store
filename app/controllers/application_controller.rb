class ApplicationController < ActionController::API

  def index
      render json: {message: "Welcome to Beauty store api service"} ,status: :ok
  end

  def respond_not_found(title="Invalid Record Id", detail="No matching records found for id: #{params[:id]}")
    render json: {
     	errors: [{
       	status: "404",
       	code: "NOT_FOUND",
  	    source: { 
  	     	pointer: pointer 
  	    },
  	    title: title,
  	    detail: detail
     	}]
    }, status: 404
  end

  def respond_internal_error(pointer="/record_id") 
    render json: {
      errors: [
        {
          status: "500",
          source: { "pointer" => pointer },
          title:  "Internal Server Error",
          detail: "Please contact support team with the URL"
        }
      ]
    }, status: 500
  end

  def invalid_auth_json_response
    render json: {
      errors: [{
        status: "401",
        code: "UNAUTHORIZED",
        source: { "pointer": pointer },
        title:  "Authentication Failed - Invalid Token",
        detail: "Pass valid username and password to get JWT token"
      }]
    }, status: 401
  end
    
  def invalid_token_json_response
    render json: {
      errors: [{
        status: "401",
        code: "UNAUTHORIZED",
        source: { pointer: pointer },
        title:  "Authentication Failed - Invalid Token",
        detail: "Valid JWT token should be used in http header in order to access"
        }
      ]
    }, status: 401
  end

  def pointer
    request.original_url
  end

end
