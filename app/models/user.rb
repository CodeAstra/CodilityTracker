class User < ActiveRecord::Base
  # Include default devise modules. Others available are:
  # :confirmable, :lockable, :timeoutable and :omniauthable
  # devise :database_authenticatable, :registerable,
  #        :recoverable, :rememberable, :trackable, :validatable

  devise :rememberable, :trackable,
          :omniauthable, :omniauth_providers => [:github]


  def self.from_omniauth(auth)
    # Example auth data:
    #   request.env["omniauth.auth"].info
    #   #<OmniAuth::AuthHash::InfoHash
        #   email="bvsatyaram@gmail.com"
        #   image="https://avatars.githubusercontent.com/u/166072?v=3"
        #   name="B V Satyaram"
        #   nickname="bvsatyaram"
        #   urls=#<OmniAuth::AuthHash Blog="http://www.bvsatyaram.com" GitHub="https://github.com/bvsatyaram">
        # >
    where(provider: auth.provider, uid: auth.uid).first_or_create do |user|
      user.email = auth.info.email
      # user.password = Devise.friendly_token[0,20]
      user.name = auth.info.name   # assuming the user model has a name
      user.image = auth.info.image # assuming the user model has an image
      user.nickname = auth.info.nickname
      user.github_url = auth.info.urls.GitHub
    end
  end

  def self.new_with_session(params, session)
    super.tap do |user|
      if data = session["devise.facebook_data"] && session["devise.facebook_data"]["extra"]["raw_info"]
        user.email = data["email"] if user.email.blank?
      end
    end
  end
end
