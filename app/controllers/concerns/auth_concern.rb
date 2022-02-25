# frozen_string_literal: true

module AuthConcern
  def sign_in(user)
    session[:user_id] = user.id
  end

  def sign_out
    reset_session
    redirect_back fallback_location: root_path
  end

  def signed_in?
    session[:user_id].present? && current_user.present?
  end

  def current_user
    @current_user ||= User.find_by(id: session[:user_id])
  end

  def require_signed_in_user!
    return if current_user

    redirect_to root_path
  end

  def user_not_authorized
    redirect_to root_path, alert: t('notice.auth.not_authorized')
  end
end
