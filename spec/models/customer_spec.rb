# coding: utf-8
require 'spec_helper'

describe Customer, 'Validation' do
  let(:customer) do 
    build(:customer)
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

    specify "#{column_name} should be translated to Fullwidth Katakana when included Halfwidth Katakana" do
      customer[column_name] = 'ｱｲｳｴｵ'
      expect(customer).to be_valid
      expect(customer[column_name]).to eq('アイウエオ')
    end
  end

  %w{family_name given_name}.each do |column_name|
    specify "#{column_name} is able to include Kanji, Hiragana and Katakana" do
      customer[column_name] = '亜あアー'
      expect(customer).to be_valid
    end

    specify "#{column_name} should be included Kanji, Hiragana and Katakana only" do
      ['a', '1', '@'].each do |value|
        customer[column_name] = value
        expect(customer).not_to be_valid
        expect(customer.errors[column_name]).to be_present
      end
    end
  end

  %w{family_name_kana given_name_kana}.each do |column_name|
    specify "#{column_name} should be included Katakana only" do
      ['亜', 'A', '1', '@'].each do |value|
        customer[column_name] = value
        expect(customer).not_to be_valid
        expect(customer.errors[column_name]).to be_present
      end
    end

    specify "#{column_name} should be translated to Katakana when included Hiragana" do
      customer[column_name] = 'あいうえお'
      expect(customer).to be_valid
      expect(customer[column_name]).to eq('アイウエオ')
    end
  end
end

describe Customer, 'password=' do
  let(:customer) do
    build(:customer, username: 'taro')
  end

  specify '生成された password_digest は 60 文字' do
    customer.password = 'any_string'
    customer.save!
    expect(customer.password_digest).not_to be_nil
    expect(customer.password_digest.size).to eq(60)
  end

  specify '空文字を与えると password_digest は nil' do
    customer.password = ''
    customer.save!
    expect(customer.password_digest).to be_nil
  end
end

describe Customer, '.authenticate' do
  let(:customer) do
    create(:customer, username: 'taro', password: 'correct_password')
  end

  specify 'ユーザー名とパスワードに該当するオブジェクトを返す' do
    result = Customer.authenticate(customer.username, 'correct_password')
    expect(result).to eq(customer)
  end

  specify 'パスワードが一致しない場合はnilを返す' do
    result = Customer.authenticate(customer.username, 'wrong_password')
    expect(result).to be_nil
  end

  specify '該当するユーザーが存在しない場合はnilを返す' do
    result = Customer.authenticate('hanako', 'any_string')
    expect(result).to be_nil
  end

  specify 'パスワード未設定のユーザーを拒絶' do
    customer.update_column(:password_digest, nil)
    result = Customer.authenticate(customer.username, '')
    expect(result).to be_nil
  end

  specify 'ログインに成功すると、ユーザーの保有ポイントが1増える' do
    expect {
      Customer.authenticate(customer.username, 'correct_password')
    }.to change { customer.points }.by(1)
  end
end

describe Customer, '#points' do
  let(:customer) do
    create(:customer, username: 'taro')
  end

  specify '関連付けられた Reword の points を合計して返す' do
    customer.rewords.create(points:  1)
    customer.rewords.create(points:  5)
    customer.rewords.create(points: -2)

    expect(customer.points).to eq(4)
  end
end
