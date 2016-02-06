class AddPhotoToShop < ActiveRecord::Migration
  def up
    add_attachment :shops, :photo
  end

  def down
    remove_attachment :shops, :photo
  end
end
