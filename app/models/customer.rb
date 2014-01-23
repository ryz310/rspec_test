#codeing: utf-8

class Customer < ActiveRecord::Base
  validates :family_name, :family_name_kana, :given_name, :given_name_kana, 
    presence: true, 
    length:   {maximum: 40}
  validates :family_name, :given_name,
    format:   {with: /\A[\p{Han}\p{Hiragana}\p{Katakana}]+\z/, allow_blank: true}
  validates :family_name_kana, :given_name_kana,
    format:   {with: /\A\p{Katakana}+\z/, allow_blank: true}
end
