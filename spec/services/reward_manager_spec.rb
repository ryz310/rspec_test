# coding: utf-8
require 'spec_helper'

describe RewardManager, '#grant_login_points' do
  let(:customer) do
    create(:customer)
  end

  specify '日付変更時刻をまたいで 2 回ログインすると、ユーザーの保有ポイントが 2 増える' do
    Time.zone = 'Tokyo'
    date_boundary = Time.zone.local(2013, 1, 1, 5, 0, 0)
    expect {
      Timecop.freeze(date_boundary.advance(seconds: -1))
      RewardManager.new(customer).grant_login_points
      Timecop.freeze(date_boundary)
      RewardManager.new(customer).grant_login_points
    }.to change { customer.points }.by(2)
  end

  specify '日付変更時刻をまたがずに 2 回ログインしても、ユーザーの保有ポイントは 1 しか増えない' do
    date_boundary = Time.zone.local(2013, 1, 1, 5, 0, 0)
    expect {
      Timecop.freeze(date_boundary)
      RewardManager.new(customer).grant_login_points
      Timecop.freeze(date_boundary.advance(hours: 24, seconds: -1))
      RewardManager.new(customer).grant_login_points
    }.to change { customer.points }.by(1)
  end
end