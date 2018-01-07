module BeautyStore
	class ProductsData
		include ProductUtils
		
		attr_reader :offset, :limit, :filter, :sort, :url
		attr_accessor :result

		def initialize(url="/products", offset=0, limit=10, filter=nil, sort=nil)
			@url = url
			@offset = offset || 0
			@limit = limit || 10
			@filter = filter 
			@sort = sort
		end

		def json_response
      json_data = data
			{
        "meta" => {  
					"total_records" => result.count,
					"links" => ref_links
				},
        "data" => json_data
			}
		end

		def data
      order = ""
      category_condition = ""
      order = "price #{sort[:price]}" if sort.present? && sort[:price].present?

      if filter.present? && filter[:category].present?
        category = Category.find_by(name: filter[:category])
        category_condition = "category_id=#{category.id}" if category.present?
      end

      category_condition = "price=#{filter[:price]}" if filter.present? && filter[:price].present?

      @result = Product.where(category_condition)

      products = Product.where(category_condition).order(order).offset(offset).limit(limit)

      json_data = []
      products.each do |product|
        res = product.data_json
        res["links"] = {
          "self" => "#{url}/#{product.id}"
        }
        json_data << res
      end
			return json_data
		end
	end
end