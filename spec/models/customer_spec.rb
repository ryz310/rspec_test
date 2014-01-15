# coding: utf-8
require 'spec_helper'

describe Customer do
  specify "column 'family_name' should not be empty" do
    customer = Customer.new(
      family_name: '',
      given_name: '太郎',
      family_name_kana: 'ヤマダ',
      given_name_kana: 'タロウ'
    )
    expect(customer).not_to be_valid
    expect(customer.errors[:family_name]).to be_present
  end
end
