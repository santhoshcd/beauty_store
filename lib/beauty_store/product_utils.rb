module BeautyStore
  module ProductUtils

  	def current_page
  		offset / limit
  	end

    def filter_query
      query = ""
      if filter.present? 
        query << "&filter[category]=#{filter[:category]}" if filter[:category].present?
        query << "&filter[price]=#{filter[:price]}" if filter[:price].present?
      end
      query
    end

    def sort_query
      query = ""
      query = "&sort[price]=#{sort[:price]}" if sort.present? && sort[:price].present?
      query
    end

  	def self_url
      current_page_url = "#{url}?page[limit]=#{limit}&page[offset]=#{offset}"
      current_page_url << sort_query
      current_page_url << filter_query
      current_page_url
  	end

  	def next_url
      next_offset = (current_page + 1) * limit
      if result.count > next_offset
        next_page_url = "#{url}?page[limit]=#{limit}&page[offset]=#{next_offset}"
        next_page_url << sort_query
        next_page_url << filter_query
      end
      next_page_url
  	end

  	def prev_url
      prev_offset = (current_page - 1 ) * limit
      if prev_offset > -1
        prev_page_url = "#{url}?page[limit]=#{limit}&page[offset]=#{prev_offset}"
        prev_page_url << sort_query
        prev_page_url << filter_query
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