class AddUserIdToBoke < ActiveRecord::Migration
  def change
    add_reference :bokes, :user, index: true, foreign_key: true
  end
end
