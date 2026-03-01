# == Schema Information
#
# Table name: users
#
#  id               :bigint           not null, primary key
#  first_login_flag :boolean          default(FALSE), not null
#  is_deleted       :boolean
#  name             :string           default(""), not null
#  provider         :string           default(""), not null
#  uid              :string           default(""), not null
#  created_at       :datetime         not null
#  updated_at       :datetime         not null
#
# Indexes
#
#  index_users_on_provider_and_uid  (provider,uid) UNIQUE
#
class User < ApplicationRecord
  validates :name, presence: true, length: { maximum: 30 }
  validates :provider, presence: true
  validates :uid, presence: true
  validates :provider, uniqueness: { scope: :uid }
  # Include default devise modules. Others available are:
  # :confirmable, :lockable, :timeoutable, :trackable and :omniauthable
  devise :omniauthable, omniauth_providers: [ :line ]

  has_many :anniversaries, dependent: :destroy
  has_one :partner, dependent: :destroy
  has_many :gift_suggestions, dependent: :destroy


  def self.from_line(auth)
    where(provider: auth.provider, uid: auth.uid).first_or_create do |user|
      user.name = auth.info.name
    end
  end
# 論理削除あり
  # def self.from_line(auth)
  #   user = find_by(provider: auth.provider, uid: auth.uid)

  #   if user
  #     user.update!(is_deleted: false) if user.is_deleted?
  #     user
  #   else 
  #     create!(
  #       provider: auth.provider, 
  #       uid: auth.uid,
  #       name: auth.info.name
  #     )
  #   end
  # end

  def self.ransackable_attributes(auth_object = nil)
    ["created_at", "id", "name"]
  end
end
