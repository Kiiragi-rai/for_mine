class PagesController < ApplicationController
  def contact
    set_meta_tags(
      title: "お問い合わせ"
    )
  end

  def privacy
    set_meta_tags(
      title: "プライバシーポリシー"
    )
  end

  def terms
    set_meta_tags(
      title: "利用規約"
    )
  end
end
