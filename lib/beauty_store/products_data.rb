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
      conditions_query = []
      conditions_values = {}

      if filter.present? && 
        if filter[:category].present?
          category = Category.find_by(name: filter[:category])
          if category.present?
            conditions_query << "category_id = :category"
            conditions_values[:category] = category.id
          end
        end
      
        if filter[:price].present?
          conditions_query << "price = :price" 
          conditions_values[:price] = filter[:price].to_i
        end
      end

      conditions_query = conditions_query.join(" and ")

      @result = Product.where(conditions_query, conditions_values)

      if sort.present? && sort[:price].present?
          @result = ((sort[:price].to_s.downcase == "desc") ? @result.ordered_by_price_desc : @result.ordered_by_price_asc)
      end
      
      products = @result.paginate_results(offset: offset, limit:limit).includes(:category)

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