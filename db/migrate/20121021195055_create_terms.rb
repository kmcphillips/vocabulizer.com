class CreateTerms < ActiveRecord::Migration
  def up
    create_table :terms do |t|
      t.string :value
      t.string :base_value
      t.string :type
      t.string :creator_id

      t.timestamps
    end

    add_index :terms, :type
    add_index :terms, :value
    add_index :terms, :base_value
    add_index :terms, :creator_id

    create_table :term_details do |t|
      t.integer :term_id
      t.string :source
      t.text :definition
      t.text :example

      t.timestamps
    end

    add_index :term_details, :term_id
  end

  def down
    drop_table :terms
    drop_table :term_details
  end
end
