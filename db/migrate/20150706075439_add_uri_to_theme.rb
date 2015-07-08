class AddUriToTheme < ActiveRecord::Migration
  def change
    add_column :themes, :uri, :string, null: false
  end
end
