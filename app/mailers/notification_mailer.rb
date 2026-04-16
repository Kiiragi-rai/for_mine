class NotificationMailer < ApplicationMailer
  # attr_accessor :email,:title
  # 仮引数に@付きのインスタンス変数は指定できませんので注意
  def send_notification_mail(email, title)
    # インスタンス変数に格納
    @email = email
    @title = title
    # メールの宛先を指定
    # メールのタイトルを指定
    mail to: @email,
         subject: "[記念日]#{@title}"
  end
end
