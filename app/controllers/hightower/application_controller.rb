module Hightower
  class ApplicationController < ::ApplicationController
    before_filter :ensure_authorized
    def hightower_user
      send(Hightower.current_user_method)
    end

    def hightower_authorized?
      (hightower_user.present? && hightower_user.send(Hightower.authorization_method))
    end

    def ensure_authorized
      redirect_unauthorized unless hightower_authorized?
    end

    def redirect_unauthorized
      flash[:alert] = t('hightower.access_denied')
      redirect_to Hightower.redirect_unauthorized_path
    end
  end
end
