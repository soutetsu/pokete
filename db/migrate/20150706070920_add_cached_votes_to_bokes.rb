class AddCachedVotesToBokes < ActiveRecord::Migration
  def self.up
    add_column :bokes, :cached_votes_total, :integer, :default => 0
    add_column :bokes, :cached_votes_score, :integer, :default => 0
    add_column :bokes, :cached_votes_up, :integer, :default => 0
    add_column :bokes, :cached_weighted_score, :integer, :default => 0
    add_column :bokes, :cached_weighted_total, :integer, :default => 0
    add_column :bokes, :cached_weighted_average, :float, :default => 0.0
    add_index  :bokes, :cached_votes_total
    add_index  :bokes, :cached_votes_score
    add_index  :bokes, :cached_votes_up
    add_index  :bokes, :cached_weighted_score
    add_index  :bokes, :cached_weighted_total
    add_index  :bokes, :cached_weighted_average
  end

  def self.down
    remove_column :bokes, :cached_votes_total
    remove_column :bokes, :cached_votes_score
    remove_column :bokes, :cached_votes_up
    remove_column :bokes, :cached_weighted_score
    remove_column :bokes, :cached_weighted_total
    remove_column :bokes, :cached_weighted_average
  end
end
