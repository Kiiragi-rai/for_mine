Capybara.register_driver :remote_chrome do |app|
  # Chromeの設定をまとめる箱
  options = Selenium::WebDriver::Chrome::Options.new
    # Docker用　ないとChrome起動できないことある
    options.add_argument('no-sandbox')
    # 画面表示しない　裏でブラウザ動く
    options.add_argument('headless')
    # GPU使わない（安定化）
    options.add_argument('disable-gpu')
    options.add_argument('window-size=1680,1050')
    # Driver作成　r  remote : ローカルじゃなくて, 別コンテナのChrome使う
    # ttp://selenium:4444/wd/hub_　　Dockerのseleniumコンテナ,  　 capabilities　　さっきのoptions渡してる
    # Railsコンテナ → Seleniumコンテナ → Chrome
    Capybara::Selenium::Driver.new(app, browser: :remote, url: ENV['SELENIUM_DRIVER_URL'], capabilities: options)
  end
