require 'rails_helper'

RSpec.describe Services::Api::V1::ProductsController, type: :controller do
	
	before(:all) do
		Category.destroy_all
		Product.destroy_all
		category = create(:category)
		create(:product, category: category)
		create(:product, category: category)
    
    category1 = create(:category)
    create(:product, category: category1)

    PRODUCT_DEFAULT_LIMIT = 10
	end

	context "Products" do

		it "Should return 401 if token is an invalid" do
      request.env['HTTP_AUTHORIZATION'] = "Bearer AWSCD"

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
	 
    context "Products details" do
      before do
        payload = {
          data: {
            username: "test",
          }
        }
        token = JsonWebToken.encode payload
        request.env['HTTP_AUTHORIZATION'] = "Bearer #{token}"
      end

      it "should return products details" do
        products = Product.all
        limit = PRODUCT_DEFAULT_LIMIT
        offset = 0
        expected_result = {
          "meta" => {
            "total_records" => products.count,
            "links" => {
              "self" => "http://test.host/services/api/v1/products?page[limit]=#{PRODUCT_DEFAULT_LIMIT}&page[offset]=#{offset}",
              }
          },
          "data" => [
          ]
        }

        products.each do |product|
          expected_result["data"] << {
            "data" => {
              "type" => "products",
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
        end

        get :index
        result = JSON.parse(response.body)
        expect(response.code).to eq("200")
        expect(result).to eq(expected_result) 
      end

      it "should get products details based on paginate" do
        offset = 0
        limit = 1
        total_products = Product.count
        products = Product.all.offset(offset).limit(limit)
        next_offset = (offset + 1) * limit
        expected_result = {
          "meta" => {
            "total_records" => total_products,
            "links" => {
              "self" => "http://test.host/services/api/v1/products?page[limit]=#{limit}&page[offset]=0",
              "next" => "http://test.host/services/api/v1/products?page[limit]=#{limit}&page[offset]=#{next_offset}",
              }
          },
          "data" => [
          ]
        }

        products.each do |product|
          expected_result["data"] << {
            "data" => {
              "type" => "products",
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
        end

        get :index, params: {page: {limit: limit, offset: offset}}
        result = JSON.parse(response.body)
        expect(response.code).to eq("200")
        expect(result).to eq(expected_result) 
      end

      it "should get products details based on price sort ascending order" do
        offset = 0
        limit = 1
        order = "asc"

        total_products = Product.count
        products = Product.all.offset(offset).limit(limit)
        next_offset = (offset + 1) * limit
        expected_result = {
          "meta" => {
            "total_records" => total_products,
            "links" => {
              "self" => "http://test.host/services/api/v1/products?page[limit]=#{limit}&page[offset]=0&sort[price]=#{order}",
              "next" => "http://test.host/services/api/v1/products?page[limit]=#{limit}&page[offset]=#{next_offset}&sort[price]=#{order}",
              }
          },
          "data" => [
          ]
        }

        products.each do |product|
          expected_result["data"] << {
            "data" => {
              "type" => "products",
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
        end

        get :index, params: {page: {limit: limit, offset: offset}, sort: {price: order}}
        result = JSON.parse(response.body)
        expect(response.code).to eq("200")
        expect(result).to eq(expected_result) 
      end

      it "should get filtered products details based on category" do
        offset = 0
        limit = 1
        order = "asc"
        filter_category_value = "makeup"
        category = Category.last
        category.name = filter_category_value
        category.save

        total_products = Product.where("category_id = #{category.id}").count
        products = Product.where("category_id = #{category.id}").order("price asc").offset(offset).limit(limit)

        next_offset = (offset + 1) * limit
        expected_result = {
          "meta" => {
            "total_records" => total_products,
            "links" => {
              "self" => "http://test.host/services/api/v1/products?page[limit]=#{limit}&page[offset]=0&sort[price]=#{order}&filter[category]=#{filter_category_value}",
              "next" => "http://test.host/services/api/v1/products?page[limit]=#{limit}&page[offset]=#{next_offset}&sort[price]=#{order}&filter[category]=#{filter_category_value}",
              }
          },
          "data" => [
          ]
        }

        products.each do |product|
          expected_result["data"] << {
            "data" => {
              "type" => "products",
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
        end

        get :index, params: {page: {limit: limit, offset: offset}, sort: {price: order}, filter: {category: filter_category_value}}
        result = JSON.parse(response.body)
        expect(response.code).to eq("200")
        expect(result).to eq(expected_result) 
      end

  		context "A Product details" do
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
              "type" => "products",
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
end
