class PartnersController < ApplicationController
    before_action :authenticate_user!
#has one はpartner s付かない
    def index
        @partner = current_user.partner
    end
end
