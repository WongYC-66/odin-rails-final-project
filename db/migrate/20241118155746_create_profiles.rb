class CreateProfiles < ActiveRecord::Migration[8.0]
  def change
    create_table :profiles do |t|
      t.references :user
      t.string :first_name
      t.string :last_name
      t.string :description
      t.string :img_url
      t.timestamps
    end
  end
end
