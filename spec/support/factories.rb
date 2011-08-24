FactoryGirl.define do
  factory :user do
    sequence(:name)       { |n| "user#{n}" }
    email                 { "#{name}@host.com" }
    password              { "qwerty" }
    password_confirmation { "qwerty" }
  end
  factory :survey do
    user
    sequence(:title)  { |n| "survey#{n}" }
    is_private        { false }
    factory :private_survey do
      is_private      { true }
    end
  end
  factory :question do
    survey
    sequence(:title)  { |n| "question#{n}" }
  end
  factory :choice do
    question
    sequence(:title)  { |n| "choice#{n}" }
  end
  factory :answer do
    choice
    user
    survey
  end
  factory :watch do
    user
    survey
  end
end