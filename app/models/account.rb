class Account < ApplicationRecord
  include Clearance::User

  # https://stackoverflow.com/a/33632569/1049688
  PASSWORD_FORMAT = /\A
  (?=.*\d)           # Must contain a digit
  (?=.*[a-z])        # Must contain a lower case character
  (?=.*[A-Z])        # Must contain an upper case character
  /x

  validates :email,
            uniqueness: {
              case_sensitive: false
            }

  validates :password,
            presence: true,
            confirmation: true,
            format: { with: PASSWORD_FORMAT },
            length: { minimum: 8 }
end
