class Customer < ActiveRecord::Base
  validates :family_name, :family_name_kana, :given_name, :given_name_kana, presence: true
end
