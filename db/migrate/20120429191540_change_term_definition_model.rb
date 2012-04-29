class ChangeTermDefinitionModel < ActiveRecord::Migration
  def up
    create_table :terms_users, :id => false do |t|
      t.integer :term_id
      t.integer :user_id
    end

    add_index :terms_users, :term_id
    add_index :terms_users, :user_id
    add_index :terms_users, [:term_id, :user_id]

    add_column :terms, :last_successful_update_at, :datetime
    add_index :terms, :last_successful_update_at
  end

  def down
    drop_table :terms_users
    remove_column :terms, :last_successful_update_at
  end
end
