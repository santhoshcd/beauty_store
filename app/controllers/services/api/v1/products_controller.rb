require "beauty_store/products_data"
class Services::Api::V1::ProductsController < Services::Api::AuthController

  def index
    page = params[:page]
    filter = params[:filter]
    sort = params[:sort]

    if page.present? 
      offset = page[:offset].to_i 
      limit = page[:limit].to_i
    else
      offset = nil 
      limit = nil
    end

    url = "#{request.base_url}#{request.path}"
    products = BeautyStore::ProductsData.new(url, offset, limit, filter, sort)
    json_data = products.json_response
    render json: json_data, status: :ok
  end

  def show
    post = Product.find_by(id: params[:product_number])
    if post.present?
      json_data = {
        data: post.data_json,
        links: {
          self: pointer
        }
      }
      render json: json_data, status: :ok
    else
      respond_not_found("Invalid Product Number", "No matching Product found in Beauty Store for the given Product Number")
    end
  end

end
