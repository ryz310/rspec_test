# coding: utf-8

FactoryGirl.define do 
  factory :customer do
    username         'taro'
    family_name      '山田'
    given_name       '太郎'
    family_name_kana 'ヤマダ'
    given_name_kana  'タロウ'
  end
end