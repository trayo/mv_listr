class User < ActiveRecord::Base
  has_and_belongs_to_many :recommendations

  def self.find_or_create_by_auth(auth_data)
    user = User.where(uid: auth_data["uid"]).first_or_create
    user.tap do |u|
      u.update_attributes(name: auth_data["info"]["name"], screen_name: auth_data["info"]["screen_name"])
    end
  end
end
