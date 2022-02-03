# frozen_string_literal: true

class ApplicationController < ActionController::Base
  include AuthManagement

  helper_method :signed_in?, :sign_out
end
