class User < ApplicationRecord
  # Include default devise modules. Others available are:
  # :confirmable, :lockable, :timeoutable, :trackable and :omniauthable
  devise :database_authenticatable, :registerable,
    :recoverable, :rememberable, :validatable,
    :omniauthable, omniauth_providers: %i[google_oauth2]

  def self.from_google(provider_user)
    create_with(
      provider_uid: provider_user[:uid],
      provider: "google",
      password: Devise.friendly_token[0, 20]
    ).find_or_create_by!(email: provider_user[:email])
  end
end
