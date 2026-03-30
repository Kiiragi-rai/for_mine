class HomePagesController < ApplicationController
    before_action :authenticate_user!

    def index
        set_meta_tags(
            title: "ホーム"
          )
    
    end
end
