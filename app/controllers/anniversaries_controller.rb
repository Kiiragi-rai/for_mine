class AnniversariesController < ApplicationController
    before_action :authenticate_user!

    def index
        @anniversaries = Anniversary.includes(:user)
    end
end
