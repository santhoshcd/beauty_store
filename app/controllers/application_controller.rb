class ApplicationController < ActionController::API

  def index
      render json: {message: "Welcome to Beauty store api service"} ,status: :ok
  end

  def respond_not_found(pointer="/record_id", title="Invalid Record Id", detail="No matching records found for id: #{params[:id]}")
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

  def invalid_token_json_response
    render json: {
      errors: [{
        status: "401",
        code: "UNAUTHORIZED",
        source: { "pointer": "/api/v1/auth/token" },
        title:  "Authentication Failed - Invalid Token",
        detail: "Pass valid username and password to get JWT token"
      }]
    }, status: 401
  end
    
end
