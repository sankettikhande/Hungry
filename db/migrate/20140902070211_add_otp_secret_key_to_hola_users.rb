class AddOtpSecretKeyToHolaUsers < ActiveRecord::Migration
  def self.up
    add_column :hola_users, :otp_secret_key, :string
    HolaUser.all.each { |user| user.update_attribute(:otp_secret_key, ROTP::Base32.random_base32) }
  end
end
