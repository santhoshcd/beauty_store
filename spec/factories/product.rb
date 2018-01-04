FactoryBot.define do
  factory :product do
    sequence(:name) {|n| "Product #{n}"}
    sold_out false
    under_sale false
    sequence(:price) {|n| (n + 100) }
    sequence(:sale_price) {|n| n + 60 }
    sale_text "90% OFF"
    association :category, factory: :category
  end
end
