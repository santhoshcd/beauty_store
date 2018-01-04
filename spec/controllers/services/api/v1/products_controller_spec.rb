require 'rails_helper'

RSpec.describe Services::Api::V1::ProductsController, type: :controller do
	
	before(:all) do
		Category.destroy_all
		Product.destroy_all
		category = create(:category)
		create(:product, category: category)
		create(:product, category: category)
	end

	context "Products" do

		it "Should return 401 if token is an invalid" do
			product_number = 10001
			expected_result = {
			  "errors" => [
			    {
			      "status" => "401",
			      "code" => "UNAUTHORIZED",
			      "source" => { "pointer" => "http://test.host/services/api/v1/products/#{product_number}" },
			      "title" =>  "Authentication Failed - Invalid Token",
			      "detail" => "Valid JWT token should be used in http header in order to access"
			    }
			  ]
			}

			get :show, params: { product_number: product_number }

			result = JSON.parse(response.body)
			expect(response.code).to eq("401")
      expect(result).to eq(expected_result) 
		end
		
		context "Product details" do
			before do
				payload = {
  			  data: {
  			    username: "test",
  			  }
  			}
  			token = JsonWebToken.encode payload
  			request.env['HTTP_AUTHORIZATION'] = "Bearer #{token}"
			end

  		it "Should return 404 if Product not found" do

  			product_number = 10001
  			
  			expected_result = {
  			  "errors" => [
  			    {
  			      "status" => "404",
  			      "code" => "NOT_FOUND",
  			      "source" => { "pointer" => "http://test.host/services/api/v1/products/#{product_number}" },
  			      "title" =>  "Invalid Product Number",
  			      "detail" => "No matching Product found in Beauty Store for the given Product Number"
  			    }
  			  ]
  			}

  			get :show, params: { product_number: product_number }

        result = JSON.parse(response.body)
        expect(response.code).to eq("404")
        expect(result).to eq(expected_result) 
  		end

	    it "Get a product details" do
  			product = Product.last
        
        expected_result = {
          "data" => {
            "type" => "product",
            "id" => "#{product.id}",
            "attributes" => {
              "product_number" => product.id,
              "name" => "#{product.name}",
              "sold_out" => product.sold_out,
              "category" => {
                "name" => "#{product.category.name}",
                "id" => "#{product.category.id}"
              },
              "under_sale" => product.under_sale,
              "price" => product.price.to_f,
              "sale_price" => product.sale_price.to_f,
              "sale_text" => "#{product.sale_text}"
            }
          },
          "links" => {
            "self" => "http://test.host/services/api/v1/products/#{product.id}"
          }
        }

  			product_number = product.id
  			get :show, params: { product_number: product_number }
  			result = JSON.parse(response.body)
        expect(response.code).to eq("200")
        expect(result).to eq(expected_result)
	    end
    end
	end
end
