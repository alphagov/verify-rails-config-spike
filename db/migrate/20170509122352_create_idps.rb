class CreateIdps < ActiveRecord::Migration[5.1]
  def change
    create_table :idps do |t|
      t.string :simple_id
      t.boolean :enabled
      t.string :entity_id
      t.string :signing_cert

      t.timestamps
    end
  end
end
