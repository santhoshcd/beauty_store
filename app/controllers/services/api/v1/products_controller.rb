class Services::Api::V1::ProductsController < Services::Api::AuthController

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
