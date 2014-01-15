# coding: utf-8
require 'spec_helper'

describe Customer do
  let(:customer) do 
    Customer.new(
      family_name:      '山田',
      given_name:       '太郎',
      family_name_kana: 'ヤマダ',
      given_name_kana:  'タロウ'
    )
  end

  specify 'valid object' do
    expect(customer).to be_valid
  end

  %w{family_name family_name_kana given_name given_name_kana}.each do |column_name|
    specify "#{column_name} should not be empty" do
      customer[column_name] = ''
      expect(customer).not_to be_valid
      expect(customer.errors[column_name]).to be_present
    end

    specify "#{column_name} should be less than 40 characters" do
      customer[column_name] = "あ" * 41
      expect(customer).not_to be_valid
      expect(customer.errors[column_name]).to be_present
    end
  end
end