class CreateEvaluations < ActiveRecord::Migration
  def change
    create_table :evaluations do |t|
      t.references :user, index: true, foreign_key: true
      t.references :boke, index: true, foreign_key: true
      t.integer :point, null: false
      t.string :comment

      t.timestamps null: false
    end
    add_index :evaluations, [:user_id, :boke_id], unique: true
  end
end
