FactoryGirl.define do
  factory :learning_objective_level do
    association :objective, factory: :learning_objective

    name { Faker::Hacker.noun }
    description { Faker::Hacker::say_something_smart }
    flagged_value :green

    trait :flagged_green do
      flagged_value :green
    end

    trait :flagged_yellow do
      flagged_value :yellow
    end

    trait :flagged_red do
      flagged_value :red
    end
  end
end
