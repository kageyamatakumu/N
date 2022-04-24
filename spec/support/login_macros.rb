module LoginMacros
  def login_as(general)
    visit general_login_path
    fill_in 'メールアドレス', with: general.email
    fill_in 'Password', with: '12345678'
    click_button 'ログイン'
  end

  def login_owner(owner)
    visit admin_owner_login_path
    fill_in 'メールアドレス', with: owner.email
    fill_in 'Password', with: '12345678'
    click_button 'ログイン'
  end
end