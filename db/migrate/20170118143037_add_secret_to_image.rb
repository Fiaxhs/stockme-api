class AddSecretToImage < ActiveRecord::Migration[5.0]
  def change
    add_column :images, :secret, :string
  end
end
