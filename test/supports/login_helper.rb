module LoginHelper
  def login_user(login_name)
    visit new_user_session_url
    within('#new_user') do
      fill_in('user[login]', with: login_name)
      fill_in('user[password]', with: 'password')
    end
    click_button I18n.t('devise.sessions.new.sign_in')
  end

  def logout
    click_button I18n.t('layouts.header.sign_out')
  end
end