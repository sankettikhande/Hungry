class AddUserNameAndPasswordToExistingRunner < ActiveRecord::Migration
  def change
    Runner.all.each do |runner|
      if runner.username.blank? && runner.password.blank?
        runner.username = runner.name.downcase.gsub(" ", "_")
        runner.password = Base64.encode64(runner.name)
        runner.save
      end
    end
  end
end
