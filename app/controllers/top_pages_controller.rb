class TopPagesController < ApplicationController
    def top
      set_meta_tags(
        title: "トップ"
      )
    end
end
