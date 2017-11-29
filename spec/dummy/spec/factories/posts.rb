FactoryBot.define do
  factory :post do
    title 'Lorem ipsum'
    comments { FactoryBot.build_list :comment, 5 }
  end
end
