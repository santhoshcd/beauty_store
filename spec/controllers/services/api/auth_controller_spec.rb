require 'rails_helper'
require 'json_web_token'

describe Services::Api::AuthController do
  
  context "Auth Token Generator with application auth" do
  
    it "Should not send token if it is an invalid username and password" do
      expected_result = {
        "errors" => [{
            "status" => "401",
            "code" => "UNAUTHORIZED",
            "source" => { 
              "pointer" => "/api/v1/auth/token" 
            },
            "title" =>  "Authentication Failed - Invalid Token",
            "detail" => "Pass valid username and password to get JWT token"
          }
        ]
      }

      get 'token'

      result = JSON.parse(response.body)
      expect(response.code).to eq("401")
      expect(result).to eq(expected_result)
    end

    it "Should send token only if it is a valid username and password" do
      controller.stub(:api_service_username).and_return("user1")
      controller.stub(:api_service_password).and_return("test1")

      get 'token', params: { username: "user1", password: "test1" }

      result = JSON.parse(response.body)
      jwt_token = result['token']
      decoded_token = JsonWebToken.decode jwt_token
      expect(response.code).to eq("200")
      expect(decoded_token["data"]).to eq({"username"=>"user1"})
    end
  end

end