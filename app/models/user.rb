class User < ActiveRecord::Base
  has_many :user_recommendations
  has_many :recommendations, through: :user_recommendations

  def self.find_or_create_by_auth(auth_data)
    user = User.where(uid: auth_data["uid"]).first_or_create
    user.tap do |u|
      u.update_attributes(user_params(auth_data))
    end
  end

  def watched_recommendations(status)
    recommendations.joins(:user_recommendations)
                   .where("user_recommendations.watched = ?", status)
                   .order(updated_at: :desc)
  end

  protected

  def self.user_params(auth_data)
    {
      name:          auth_data["info"]["name"],
      screen_name:   auth_data["info"]["nickname"],
      uid:           auth_data["uid"],
      provider:      auth_data["provider"],
      profile_image: auth_data["extra"]["raw_info"]["profile_image_url_https"],
    }
  end
end
