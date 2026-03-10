class Admin::GiftSuggestionsController < Admin::BaseController
  def index
    @q = GiftSuggestion.ransack(params[:q])
    @gift_suggestions = @q.result(distince: true).page(params[:page]).per(10)
  end
end