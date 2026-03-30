class TopPagesController < ApplicationController
    def top
      # @user = current_user
      set_meta_tags(
        title: "for mine"
      )
    end
end
