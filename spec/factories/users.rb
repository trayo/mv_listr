FactoryGirl.define do
  factory :user do
    name        "Trevor"
    provider    "twitter"
    screen_name "omgTrevor"
    uid         "12345678"
  end
end
