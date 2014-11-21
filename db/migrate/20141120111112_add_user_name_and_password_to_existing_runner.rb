class AddUserNameAndPasswordToExistingRunner < ActiveRecord::Migration
  def change
    Runner.all.each do |runner|
      if runner.username.blank? && runner.password.blank?
        runner.username = runner.name.downcase.gsub(" ", "_")+"_"+runner.id.to_s
        runner.password = runner.username
        runner.save
      end
    end
  end
end
