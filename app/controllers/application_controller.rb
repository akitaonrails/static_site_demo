class ApplicationController < ActionController::Base
  # Prevent CSRF attacks by raising an exception.
  # For APIs, you may want to use :null_session instead.
  protect_from_forgery with: :exception

  private

    def deploy_id
      if Rails.env.production?
        ENV['DEPLOY_ID'] || '0'
      else
        rand
      end
    end
end
