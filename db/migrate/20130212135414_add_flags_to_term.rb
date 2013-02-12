class AddFlagsToTerm < ActiveRecord::Migration
  def change
    add_column :terms, :top, :boolean, default: false
    add_column :terms, :urban, :boolean, default: false

    add_index :terms, :top
    add_index :terms, :urban
  end
end
