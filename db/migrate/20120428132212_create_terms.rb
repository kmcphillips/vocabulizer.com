class CreateTerms < ActiveRecord::Migration
  def change
    create_table :terms do |t|
      t.string :value
      t.integer :user_id
      t.boolean :phrase, :default => false

      t.timestamps
    end

    add_index :terms, :user_id
  end
end
