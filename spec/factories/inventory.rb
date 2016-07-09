FactoryGirl.define do

  factory(:inventory, :class => Micro::Inventory) do
    sequence(:title) { |n| "title-#{n}" }
    count {rand(0...999)}
    product_id {rand(1...9999)}
  end
end
