module ApplicationHelper
  def default_meta_tags
    {
      site: "for mine",
      title: "大切な記念日を忘れないアプリ",
      reverse: true,
      charset: "utf-8",
      description: "大切な記念日を忘れない。LINE通知でやさしく思い出させてくれる記念日管理アプリ。プレゼント提案にも対応。",
      keywords: "記念日 通知 プレゼント提案 LINE通知",
      canonical: request.original_url,
      separator: "|",
      icon: [
        { href: image_url("favicon.png") },
        { href: image_url("for_mine_logo.png"), rel: "apple-touch-icon", sizes: "180x180", type: "image/png" }
      ],
      og: {
        site_name: :site,
        title: :title,
        description: :description,
        type: "website",
        url: request.original_url,
        image: image_url("for_mine_logo.png"), # 配置するパスやファイル名によって変更する
        locale: "ja_JP"
      },
      twitter: {
        card: "summary_large_image", # Twitterで表示する場合は大きいカードに変更
        # site: '@あなたのツイッターアカウント', # アプリの公式Twitterアカウントがあれば、アカウント名を記載
        image: image_url("for_mine_logo.png") # 配置するパスやファイル名によって変更
      }
    }
  end
end
