class AddIdentifierToImage < ActiveRecord::Migration[5.0]
  def change
    add_column :images, :identifier, :string
    add_index :images, :identifier, unique: true
  end
end
