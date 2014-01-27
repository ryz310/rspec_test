require 'spec_helper'

describe 'login' do
  before do
    create(:customer, username: 'taro', password: 'correct_password')
  end

  specify 'Success of user auth' do
    visit root_path
    within('form#new_session') do
      fill_in 'username', with: 'taro'
      fill_in 'password', with: 'correct_password'
      click_button 'Login'
    end
    expect(page).not_to have_css('form#new_session')
  end

  specify 'Fails of user auth' do
    visit root_path
    within('form#new_session') do
      fill_in 'username', with: 'taro'
      fill_in 'password', with: 'wrong_password'
      click_button 'Login'
    end
    expect(page).to have_css('p.alert', text: 'Invalid username or password.')
    expect(page).to have_css('form#new_session')
  end
end