require 'spec_helper'

describe 'Top Page' do
  specify 'Show greeting message.' do
    visit root_path
    expect(page).to have_css('p', text: 'Hello World!')
  end
end