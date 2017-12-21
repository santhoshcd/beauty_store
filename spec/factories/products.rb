FactoryBot.define do
  factory :product do
    product_number 1
    name "MyString"
    sold_out false
    under_sale false
    price "9.99"
    sale_price "9.99"
    sale_text "MyString"
    category nil
  end
end
