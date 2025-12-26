class AnniversariesController < ApplicationController
    before_action :authenticate_user!

    def index
        @anniversaries = current_user.anniversaries
    end
end
