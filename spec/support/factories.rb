FactoryGirl.define do
  factory :user do
    sequence(:name) { |n| "foo#{n}" }
    email           { "#{name}@host.com" }
    password        { "qwerty" }
  end
end