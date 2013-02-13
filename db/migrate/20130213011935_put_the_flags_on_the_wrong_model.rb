class PutTheFlagsOnTheWrongModel < ActiveRecord::Migration
  def up
    remove_column :terms, :top
    remove_column :terms, :urban

    add_column :term_details, :top, :boolean, default: false
    add_column :term_details, :urban, :boolean, default: false

    add_index :term_details, :top
    add_index :term_details, :urban
  end

  def down
    remove_column :term_details, :top
    remove_column :term_details, :urban

    add_column :terms, :top, :boolean, default: false
    add_column :terms, :urban, :boolean, default: false

    add_index :terms, :top
    add_index :terms, :urban
  end
end
