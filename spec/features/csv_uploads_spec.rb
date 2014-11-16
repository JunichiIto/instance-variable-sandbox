require 'rails_helper'

feature 'CSV uploads', type: :feature do
  background do
    visit root_path

    click_link 'New Order'
    fill_in 'name', with: '田中'
    fill_in 'address', with: '西脇市'
    click_button '登録する'

    click_link 'Back'

    click_link 'Import CSV'
  end

  scenario '正常なCSVをアップロードする' do
    attach_file 'File', "#{Rails.root}/spec/factories/order_details.csv"
    click_button 'Import'
    expect(page).to have_content 'CSV was successfully imported.'
    expect(page).to have_content 'さとう'
    expect(page).to have_content 'しょうゆ'
  end
end