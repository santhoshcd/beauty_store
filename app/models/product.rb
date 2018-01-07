class Product < ApplicationRecord
  belongs_to :category
  validates :name, presence: true
  scope :paginate_results, -> (pagination) {
    limit( pagination[:limit].to_i ).offset( pagination[:offset] )
  }
  scope :ordered_by_price_asc, -> { order(price: :asc) }
  scope :ordered_by_price_desc, -> { order(price: :desc) }
  
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
