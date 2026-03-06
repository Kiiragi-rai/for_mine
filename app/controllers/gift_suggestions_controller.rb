require "json"

class GiftSuggestionsController < ApplicationController
  before_action :authenticate_user!
  before_action :ensure_partner!, only: [ :create ]

  def index
    @results = current_user.gift_suggestions.where.not(result_json: nil).map do |gs|
      # @results = current_user.gift_suggestions.map do |gs|
      # [] 入れた方がいいらしい
      { id: gs.id,
       names: gs.result_json&.dig("presentSuggestions")&.map { |h| h["name"] } || [] }
    end
  end

  def new
        @contents = session.delete(:gift_contents)
  end

  # パートナーがいないと　おかしくなるため、処理を変える必要あり　 viewを調整とcontrollerに処理追加
  def create
    partner_info = build_partner_info
    last_result =  current_user.gift_suggestions.success.last&.result_json

    prompt = GiftSuggestions::PromptBuilder.new(
      partner_info: partner_info,
      last_result: last_result
    ).call


        target = current_user.gift_suggestions.create!(
          input_json: partner_info,
          status: :pending
        )


        begin
        result = GiftSuggestions::Generate.new(prompt).call

        if result[:error]
          target.update!(
            status: :failure,
            error_message: result[:error]
          )
          redirect_to gift_suggestions_path, alert: "AI生成の失敗"
          return
        end

        target.update!(
          status: :success,
          result_json: result
        )

        session[:gift_contents] = result
        redirect_to new_gift_suggestion_path, notice: "提案を生成しました"

      rescue StandardError => e
        target.update!(
          status: :failure,
          error_message: e.message
        )

        redirect_to gift_suggestions_path, alert: "エラーが発生しました"
    end
  end

  # elsif Rails.env.development?
  #     @contents = {
  #   "presentSuggestions" => [
  #     { "name" => "文房具セット", "reason" => "..." },
  #     { "name" => "ポケットサイズのゲーム", "reason" => "..." },
  #     { "name" => "オリジナルのメッセージカード", "reason" => "..." }
  #   ]
  # }

  #   target = current_user.gift_suggestions.build(result_json: @contents)
  #   if target.save
  #  session[:gift_contents] = @contents
  #   redirect_to new_gift_suggestion_path, notice: "提案を生成しました"
  #   else
  #     render :new, status: :unprocessable_entity
  #   end
  # end


  def destroy
    gs = current_user.gift_suggestions.find(params[:id])

    # adminでerror確認ができるように＋　定期的にjobで消去してもいいかも
    # gs.update!(result_json: nil)
    gs.destroy!
    redirect_to gift_suggestions_path
  end

  private
  def ensure_partner!
    return if  current_user.partner.present?
    redirect_to gift_suggestions_path, alert: "先にパートナー情報を登録してください"
  end

  def build_partner_info
    partner = current_user.partner

    partner_info = {
     sex: partner.sex.presence || "未入力",
     age: partner.age.presence || "未入力",
     job: partner.job.presence || "未入力",
     relation: partner.relation.presence || "未入力",
     budget_min: partner.with_yen(partner.budget_min),
     budget_max: partner.with_yen(partner.budget_max),
     favorites: partner.turn_to_string(partner.favorites),
     avoidances: partner.turn_to_string(partner.avoidances),
     hobbies: partner.turn_to_string(partner.hobbies)
   }
  end

  # private
  # def confirm_partner_present
  #   return if current_user.partner.present?

  #   redirect_to partner_path , alert: "先にpartnerを登録してください"
  # end
end
