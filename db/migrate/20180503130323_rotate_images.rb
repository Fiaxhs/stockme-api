class RotateImages < ActiveRecord::Migration[5.0]
  def change
    Image.find_each do |image|
      image.image.recreate_versions!
    end
  end
end
