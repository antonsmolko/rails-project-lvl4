# frozen_string_literal: true

class ApplicationController < ActionController::Base
  class << self
    def default_url_options
      Rails.application.routes.default_url_options
    end
  end
end
