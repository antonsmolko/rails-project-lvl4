# frozen_string_literal: true

class Web::Repositories::ApplicationController < Web::ApplicationController
  def repository_resource
    Repository.find params[:id]
  end
end
