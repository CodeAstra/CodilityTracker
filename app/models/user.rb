class User < ActiveRecord::Base
  # Include default devise modules. Others available are:
  # :confirmable, :lockable, :timeoutable and :omniauthable
  # devise :database_authenticatable, :registerable,
  #        :recoverable, :rememberable, :trackable, :validatable

  devise :rememberable, :trackable,
         :omniauthable, :omniauth_providers => [:facebook]

  def self.from_omniauth(auth)
    # Example +auth+ data:
    # 
    #   <OmniAuth::AuthHash credentials=
    #     <OmniAuth::AuthHash expires=true expires_at=1443250922 token="XYZ">
    #     extra=
    #       <OmniAuth::AuthHash
    #         raw_info=
    #           <OmniAuth::AuthHash
    #             email="bvsatyaram@gmail.com"
    #             id="10152854613555059"
    #             name="Satyaram BV">>
    #     info=
    #       <OmniAuth::AuthHash::InfoHash
    #         email="bvsatyaram@gmail.com"
    #         image="http://graph.facebook.com/10152854613555059/picture"
    #         name="Satyaram BV">
    #     provider="facebook"
    #     uid="10152854613555059">
    where(provider: auth.provider, uid: auth.uid).first_or_create do |user|
      user.email = auth.info.email if auth.info.email
      # user.password = Devise.friendly_token[0,20]
      user.name = auth.info.name   # assuming the user model has a name
      # user.image = auth.info.image # assuming the user model has an image
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
