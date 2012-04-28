class CreateCustomDefinitions < ActiveRecord::Migration
  def change
    create_table :custom_definitions do |t|
      t.integer :term_id
      t.text :body

      t.timestamps
    end

    add_index :custom_definitions, :term_id
  end
end
