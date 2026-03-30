require "json"

class GiftSuggestionsController < ApplicationController
  before_action :authenticate_user!
  before_action :ensure_partner!, only: [ :create ]

  # def index
  #   gift_suggestions = current_user.gift_suggestions.where.not(result_json: nil).order(created_at: :asc).page(params[:page]).per(10)
  #   @results = gift_suggestions.map do |gs|
  #     # @results = current_user.gift_suggestions.map do |gs|
  #     # [] 入れた方がいいらしい
  #     { id: gs.id,
  #      names: gs.result_json&.dig("presentSuggestions")&.map { |h| h["name"] } || [] }
  #   end

  #   @gift_suggestions = gift_suggestions

  #   set_meta_tags(
  #     title: "プレゼント履歴"
  #   )
  # end
  def index
    @gift_suggestions = current_user.gift_suggestions.where.not(result_json: nil).order(created_at: :asc).page(params[:page]).per(10)

    set_meta_tags(title: "プレゼント履歴")
  end

  def new
        @contents = session.delete(:gift_contents)
        set_meta_tags(
          title: "プレゼント提案"
        )
  end
  # 今月五回使っていたら停止
  # パートナーがいないと　おかしくなるため、処理を変える必要あり　 viewを調整とcontrollerに処理追加
  def create
    if GiftSuggestion.monthly_success_count(current_user) >= 5
      redirect_to new_gift_suggestion_path, alert: "今月はここまでだよ😊\nまた来月、一緒に考えようね"
      return
    end

    # need limit fileter ( make it in model?? undef)
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

        if Rails.env.development?

          result = {
              "presentSuggestions" => [
                { "name" => "文房具セット", "reason" => "..." },
                { "name" => "ポケットサイズのゲーム", "reason" => "..." },
                { "name" => "オリジナルのメッセージカード", "reason" => "..." }
              ]
            }


              if target.update!(result_json: result, status: :success)
             session[:gift_contents] = result
              redirect_to new_gift_suggestion_path, notice: "プレゼント、一緒に考えてみたよ🎁\nいいものが見つかるといいね"
              else
                render :new, status: :unprocessable_entity
              end

        # 本番
        else
            begin
              result = GiftSuggestions::Generate.new(prompt).call

              if result[:error]
                target.update!(
                  status: :failure,
                  error_message: result[:error]
                )
                redirect_to gift_suggestions_path, alert: "うまく提案できなかったみたい…\nもう一度試してみよう🙏"
                return
              end

              target.update!(
                status: :success,
                result_json: result
              )

              session[:gift_contents] = result
              redirect_to new_gift_suggestion_path, notice: "プレゼント、一緒に考えてみたよ🎁\nいいものが見つかるといいね"

            rescue StandardError => e
              target.update!(
                status: :failure,
                error_message: e.message
              )

              redirect_to gift_suggestions_path, alert: "少し問題が起きたみたい…\n時間をおいて試してみてね🙏"
          end
          # result = {
          #   "presentSuggestions" => [
          #     { "name" => "文房具セット", "reason" => "..." },
          #     { "name" => "ポケットサイズのゲーム", "reason" => "..." },
          #     { "name" => "オリジナルのメッセージカード", "reason" => "..." }
          #   ]
          # }

          #   target = current_user.gift_suggestions.build(result_json: result)
          #   if target.save
          #  session[:gift_contents] = result
          #   redirect_to new_gift_suggestion_path, notice: "提案を生成しました"
          #   else
          #     render :new, status: :unprocessable_entity
          #   end
        end
  end




  def destroy
    gs = current_user.gift_suggestions.find_by_hashid!(params[:id])

    # adminでerror確認ができるように＋　定期的にjobで消去してもいいかも
    gs.update!(result_json: nil,
              status: :deleted,
              deleted_at: Time.current
    )
    # gs.destroy!
    redirect_to gift_suggestions_path, notice: "この提案はいったんおやすみだね🌙"
  end

  private
  def ensure_partner!
    return if  current_user.partner.present?
    redirect_to gift_suggestions_path, alert: "まずは大切な人のこと、教えてくれる？😊"
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
end
