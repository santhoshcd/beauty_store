FactoryBot.define do
  factory :product do
    sequence(:product_number) {|n| n}
    name "MyString"
    sold_out false
    under_sale false
    price "9.99"
    sale_price "9.99"
    sale_text "MyString"
    category nil
    association :category, factory: :category
  end
end
