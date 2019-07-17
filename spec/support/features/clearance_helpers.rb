module Features
  module ClearanceHelpers
    def reset_password_for(email)
      visit new_password_path
      fill_in "password_email", with: email
      click_button I18n.t("helpers.submit.password.submit")
    end

    def sign_in
      password = "#{SecureRandom.hex} #{SecureRandom.base64}"
      account = FactoryBot.create(:account, password: password)
      sign_in_with account.email, password
    end

    def sign_in_with(email, password)
      visit sign_in_path
      fill_in "session_email", with: email
      fill_in "session_password", with: password
      click_button I18n.t("helpers.submit.session.submit")
    end

    def sign_out
      click_button I18n.t("application.navigation.sign_out")
    end

    def sign_up_with(email, password)
      visit sign_up_path
      fill_in "account_email", with: email
      fill_in "account_password", with: password
      click_button I18n.t("helpers.submit.account.create")
    end

    def expect_account_to_be_signed_in
      visit root_path
      expect(page).to have_button I18n.t("application.navigation.sign_out")
    end

    def expect_account_to_be_signed_out
      visit root_path
      expect(page).to have_content I18n.t("application.navigation.sign_in")
    end

    def account_with_reset_password
      account = FactoryBot.create(:account)
      reset_password_for account.email
      account.reload
    end
  end
end

RSpec.configure do |config|
  config.include Features::ClearanceHelpers, type: :feature
end
