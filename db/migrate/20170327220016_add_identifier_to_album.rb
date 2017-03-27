class AddIdentifierToAlbum < ActiveRecord::Migration[5.0]
  def change
    add_column :albums, :identifier, :string
    add_index :albums, :identifier, unique: true
  end
end