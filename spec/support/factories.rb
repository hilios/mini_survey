FactoryGirl.define do
  factory :user do
    sequence(:name) { |n| "foo#{n}" }
    email           { "#{name}@host.com" }
    password        { "qwerty" }
  end
  factory :survey do
    user
    sequence(:title)  { |n| "foo#{n}" }
    is_private        { false }
    factory :private_survey do
      is_private      { true }
    end
  end
  factory :question do
    survey
    title   { "foo" }
  end
  factory :question_option do
    question
    title   { "bar" }
  end
  factory :answer do
    question_option
    user
  end
end