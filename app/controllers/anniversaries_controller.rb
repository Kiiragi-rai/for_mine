class AnniversariesController < ApplicationController
    @anniversaries = Anniversary.includes(:user)
end
