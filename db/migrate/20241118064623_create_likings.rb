class CreateLikings < ActiveRecord::Migration[8.0]
  def change
    create_table :likings do |t|
      t.belongs_to :post
      t.belongs_to :user
    end
  end
end
