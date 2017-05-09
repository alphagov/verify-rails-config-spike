class CreateRTransactions < ActiveRecord::Migration[5.1]
  def change
    create_table :r_transactions do |t|
      t.string :simple_id
      t.boolean :eidas_enabled
      t.string :entity_id
      t.string :signing_cert
      t.string :levels_of_assurance
      t.string :assertion_consumer_service_uri
      t.string :service_homepage
      t.string :matching_service_entity_id

      t.timestamps
    end
  end
end
