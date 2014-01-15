# coding: utf-8
require 'spec_helper'

describe Customer do
  specify 'valid object' do
    customer = Customer.new(
      family_name: '山田',
      given_name: '太郎',
      family_name_kana: 'ヤマダ',
      given_name_kana: 'タロウ'
    )
    expect(customer).to be_valid
  end

  %w{family_name family_name_kana given_name given_name_kana}.each do |column_name|
    specify "#{column_name} should not be empty" do
      customer = Customer.new(
        family_name: '山田',
        given_name: '太郎',
        family_name_kana: 'ヤマダ',
        given_name_kana: 'タロウ'
      )
      customer[column_name] = ''
      expect(customer).not_to be_valid
      expect(customer.errors[column_name]).to be_present
    end
  end
end