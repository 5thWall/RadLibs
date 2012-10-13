# Read about factories at https://github.com/thoughtbot/factory_girl

FactoryGirl.define do
  factory :word do
     template_id 1
    user_id 1
    word "MyText"
  end
end
