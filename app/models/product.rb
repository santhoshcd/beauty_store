class Product < ApplicationRecord
  belongs_to :category
  validates :name, presence: true

  def data_json
    {
  		type: "products",
  		id: "#{id}",
  		attributes: {
  			product_number: id,
  			name: name,
  			sold_out: sold_out,
  			category: {
  				name: category.name,
  				id: "#{category.id}"
  			},
  			under_sale: under_sale,
  			price: price.to_f,
  			sale_price: sale_price.to_f,
  			sale_text: sale_text
  	  }
    }  
  end

end
