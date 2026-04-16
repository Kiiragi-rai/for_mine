class ApplicationMailer < ActionMailer::Base
  # 送信元メールアドレス
  default from: "from@example.com"
  # メール全体に適用されるメールフォーム（Viewsのapplication.html.hamlなどと共通の原理かと）
  layout "mailer"
end
