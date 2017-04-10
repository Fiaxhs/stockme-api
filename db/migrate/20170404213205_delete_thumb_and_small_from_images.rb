class DeleteThumbAndSmallFromImages < ActiveRecord::Migration[5.0]
  def change
    remove_column :images, :thumb
    remove_column :images, :small
  end
end
