module BeautyStore
  module ProductUtils

  	def current_page
  		offset / limit
  	end

  	def self_url
      current_page_url = "#{url}?page[limit]=#{limit}&page[offset]=#{offset}"
      current_page_url << "&sort[price]=#{sort[:price]}" if sort.present? && sort[:price].present?
      if filter.present? 
        current_page_url << "&filter[category]=#{filter[:category]}" if filter[:category].present?
        current_page_url << "&filter[price]=#{filter[:price]}" if filter[:price].present?
      end
      current_page_url
  	end

  	def next_url
      next_offset = (current_page + 1) * limit
      if result.count > next_offset
        next_page_url = "#{url}?page[limit]=#{limit}&page[offset]=#{next_offset}"
        next_page_url << "&sort[price]=#{sort[:price]}" if sort.present? && sort[:price].present?
        if filter.present?
          next_page_url << "&filter[category]=#{filter[:category]}" if filter[:category].present?
          next_page_url << "&filter[price]=#{filter[:price]}" if filter[:price].present?
        end
      end
      next_page_url
  	end

  	def prev_url
      prev_offset = (current_page - 1 ) * limit
      if prev_offset > -1
        prev_page_url = "#{url}?page[limit]=#{limit}&page[offset]=#{prev_offset}"
        prev_page_url << "&sort[price]=#{sort[:price]}" if sort.present? && sort[:price].present?
        if filter.present?
          prev_page_url << "&filter[category]=#{filter[:category]}" if filter[:category].present?
          prev_page_url << "&filter[price]=#{filter[:price]}" if filter[:price].present?
        end
      end
      prev_page_url
  	end

  	def ref_links
  		links = {}
  		links["self"] = self_url
  		links["next"] = next_url if next_url.present?
  		links["prev"] = prev_url if prev_url.present?
  		return links
  	end
    
  end
end