Cms::DynamicView.class_eval do
  def self.base_path
    File.join(Rails.root, "uploads")
  end
end



#BCMS delete override
module Cms
  module Behaviors
    module SoftDeleting
      module InstanceMethods
        def destroy
          run_callbacks :destroy do
            if self.class.publishable?
              self.deleted = true
              self.publish_on_save = true
              self.save(validate: false)
            else
              update_attribute(:deleted, true)
            end
          end
        end
      end
    end
  end
end
