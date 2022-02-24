# frozen_string_literal: true

class Web::ApplicationController < ApplicationController
  helper_method :signed_in?, :sign_out

  include AuthManagement
  include Pundit

  rescue_from Pundit::NotAuthorizedError, with: :user_not_authorized
end
