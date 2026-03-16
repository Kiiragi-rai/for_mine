class Admin::GiftSuggestionsController < Admin::BaseController
  def index
    @q = GiftSuggestion.ransack(params[:q])
    @gift_suggestions = @q.result(distinct: true).order(created_at: :asc).page(params[:page]).per(10)
  end
end
