class CreatePosts < ActiveRecord::Migration[8.0]
  def change
    create_table :posts do |t|
      t.string :contents
      t.belongs_to :author, foreign_key: { to_table: :users }
      t.timestamps
    end
  end
end
