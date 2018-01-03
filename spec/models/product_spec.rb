require 'rails_helper'

RSpec.describe Product, type: :model do
  it { should belong_to(:category) }
  it { should validate_presence_of(:name) }
  it { should validate_uniqueness_of(:product_number) }
end