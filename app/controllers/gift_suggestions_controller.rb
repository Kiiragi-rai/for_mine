require "json"

class GiftSuggestionsController < ApplicationController
  before_action :authenticate_user!
  before_action :ensure_partner!, only: [ :create ]

  def index
    @gift_suggestions = current_user.gift_suggestions.where.not(result_json: nil).order(created_at: :asc).page(params[:page]).per(10)

    set_meta_tags(title: "プレゼントの記録")
  end

  def new
        @contents = session.delete(:gift_contents)
        set_meta_tags(
          title: "プレゼント提案"
        )
  end
  # 今月五回使っていたら停止
  def create
    # 月５回制限
    if GiftSuggestion.monthly_success_count(current_user) >= 5
      redirect_to new_gift_suggestion_path, alert: "今月はここまでだよ😊\nまた来月、一緒に考えようね"
      return
    end

    partner_info = build_partner_info
    last_result =  current_user.gift_suggestions.success.last&.result_json

    # プロンプト作成
    prompt = GiftSuggestions::PromptBuilder.new(
      partner_info: partner_info,
      last_result: last_result
    ).call


        if Rails.env.development? || Rails.env.test?
        # if Rails.env.production?

          result = {
              "presentSuggestions" => [
                { "name" => "文房具セット", "reason" => "..." },
                { "name" => "ポケットサイズのゲーム", "reason" => "..." },
                { "name" => "オリジナルのメッセージカード", "reason" => "..." }
              ]
            }


              if current_user.gift_suggestions.create(
                input_json: partner_info, 
                result_json: result, 
                status: :success
                )
             session[:gift_contents] = result
              redirect_to new_gift_suggestion_path, notice: "プレゼント、一緒に考えてみたよ🎁\nいいものが見つかるといいね"
              else
                render :new, status: :unprocessable_entity
              end

        # 本番
        else
            begin
              # プレゼント提案
              result = GiftSuggestions::Generate.new(prompt).call

              
              if result[:error]

                current_user.gift_suggestions.create!(
                  error_message: result[:error],
                  status: :failure
                  )
                redirect_to gift_suggestions_path, alert: "うまく提案できなかったみたい…\nもう一度試してみよう🙏"
                return

              end
              # input いらんくない？
              current_user.gift_suggestions.create!(
                  input_json: partner_info,
                  result_json: result,
                  status: :success
                  )

              session[:gift_contents] = result
              redirect_to new_gift_suggestion_path, notice: "プレゼント、一緒に考えてみたよ🎁\nいいものが見つかるといいね"

            rescue StandardError => e
              # こっちもcreateに
             # input いらんくない？

              current_user.gift_suggestions.create!(
                input_json: partner_info,
                status: :failure,
                error_message: e.message
              )
              redirect_to gift_suggestions_path, alert: "少し問題が起きたみたい…\n時間をおいて試してみてね🙏"
          end
 
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
  # パートナーフィルター
  def ensure_partner!
    return if  current_user.partner.present?
    redirect_to gift_suggestions_path, alert: "まずは大切な人のこと、教えてくれる？😊"
  end
# パートナー情報
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
