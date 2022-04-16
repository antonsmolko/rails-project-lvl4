# frozen_string_literal: true

class Web::AuthController < Web::ApplicationController
  def callback
    user = User.find_or_create_by auth_params

    user.nickname = auth_info[:nickname]
    user.name = auth_info[:name]
    user.email = auth_info[:email]
    user.image_url = auth_info[:image]
    user.token = auth[:credentials][:token]

    if user.save!
      sign_in user
      redirect_to root_path, notice: t('notice.auth.sign_in')
    else
      head :unauthorized, notice: t('notice.auth.authorization_failed')
    end
  end

  def destroy
    sign_out
  end

  private

  def auth_params
    { email: auth_info[:email].downcase }
  end

  def auth_info
    auth[:info]
  end

  def auth
    request.env['omniauth.auth']
  end
end
