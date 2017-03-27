class AddSecretToAlbum < ActiveRecord::Migration[5.0]
  def change
    add_column :albums, :secret, :string
  end
end
