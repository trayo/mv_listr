FactoryGirl.define do
  factory :user do
    name          "Trevor"
    screen_name   "omgTrevor"
    uid           "12345678"
    provider      "twitter"
    profile_image "http://robohash.org/1.png"
    phone_number  "+15554443333"
  end
end
