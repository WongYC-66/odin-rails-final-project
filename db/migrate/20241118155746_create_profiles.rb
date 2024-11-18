class CreateProfiles < ActiveRecord::Migration[8.0]
  def change
    create_table :profiles do |t|
      t.references :user
      t.string :first_name, default: ""
      t.string :last_name, default: ""
      t.string :description, default: ""
      t.string :img_url, default: ""
      t.timestamps
    end
  end
end
