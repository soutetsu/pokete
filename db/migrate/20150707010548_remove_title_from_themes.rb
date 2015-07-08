class RemoveTitleFromThemes < ActiveRecord::Migration
  def change
    remove_column :themes, :title, :string
  end
end
