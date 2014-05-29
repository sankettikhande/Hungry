Cms::DynamicView.class_eval do
  def self.base_path
    File.join(Rails.root, "uploads")
  end
end
