# == Schema Information
#
# Table name: admins
#
#  id                     :bigint           not null, primary key
#  email                  :string           default(""), not null
#  encrypted_password     :string           default(""), not null
#  remember_created_at    :datetime
#  reset_password_sent_at :datetime
#  reset_password_token   :string
#  created_at             :datetime         not null
#  updated_at             :datetime         not null
#
# Indexes
#
#  index_admins_on_email                 (email) UNIQUE
#  index_admins_on_reset_password_token  (reset_password_token) UNIQUE
#
class Admin < ApplicationRecord
  # Include default devise modules. Others available are:
  # :confirmable, :lockable, :timeoutable, :trackable and :omniauthable
  devise :database_authenticatable, 
        :rememberable, :validatable

   validate :accept_only_one_admin, on: :create

   before_update :prevent_update

   private 

   def accept_only_one_admin
    if Admin.exists?
      error.add(:base, "Adminは1人だけですよ")
    end
   end

   def prevent_update
    errors.add(:base, "Adminは更新できません")
   end
end
