class CreateCustomDefinitions < ActiveRecord::Migration
  def change
    create_table :definitions do |t|
      t.integer :term_id
      t.string :type
      t.text :body
      t.text :example

      t.timestamps
    end

    add_index :definitions, :term_id
    add_index :definitions, :type
  end
end
