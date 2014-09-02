class CreatePartyOrderContentType < ActiveRecord::Migration
  def change
    Cms::ContentType.create!(:name => "PartyOrder", :group_name => "PartyOrder")
    # c = Cms::ContentTypeGroup.create(:name => "PartyOrders")
    # Cms::ContentType.create(:name => "PartyOrders", :content_type_group_id => c.id )
  end

  def down
  end
end
