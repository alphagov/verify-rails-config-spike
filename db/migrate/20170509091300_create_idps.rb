class CreateIdps < ActiveRecord::Migration[5.1]
  def change
    create_table :idps do |t|
      t.text :display_data
      t.boolean :enabled
      t.string :entity_id

      t.timestamps
    end
  end
end
