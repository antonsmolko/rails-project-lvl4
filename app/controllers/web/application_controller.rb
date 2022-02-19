# frozen_string_literal: true

class Web::ApplicationController < ApplicationController
  include AuthManagement

  helper_method :signed_in?, :sign_out
end
