class CreateBokes < ActiveRecord::Migration
  def change
    create_table :bokes do |t|
      t.references :theme, index: true, foreign_key: true
      t.string :content, null: false

      t.timestamps null: false
    end
  end
end
