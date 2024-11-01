class IndexController < ApplicationController
    before_action :redirect_if_logged_in
    def index

    end

    private

    def redirect_if_logged_in
        if user_signed_in?
            if current_user.role == "authority"
                redirect_to authority_dashboard_path
            elsif current_user.role == "normal_user"
                redirect_to normal_user_dashboard_path
            end
        end
    end
end
