class CreateComments < ActiveRecord::Migration[8.0]
  def change
    create_table :comments do |t|
      t.string :contents
      t.references :post
      t.belongs_to :commentor, foreign_key: { to_table: :users }
      t.timestamps
    end
  end
end
