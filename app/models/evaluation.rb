# == Schema Information
#
# Table name: evaluations
#
#  id         :integer          not null, primary key
#  user_id    :integer
#  boke_id    :integer
#  point      :integer          not null
#  comment    :string
#  created_at :datetime         not null
#  updated_at :datetime         not null
#

class Evaluation < ActiveRecord::Base
  belongs_to :user
  belongs_to :boke

  validates :user_id, presence: true, numericality: { only_integer: true, greater_than: 0 }
  validates :boke_id, presence: true, numericality: { only_integer: true, greater_than: 0 }
  validates :point, presence: true, numericality: {only_integer: true, greater_than: 0 }
  validates :comment, length: { maximum: 255 }
  validates_uniqueness_of :user_id, scope: :boke_id

  after_create :vote
  after_destroy :unvote

  private

    def vote
      self.boke.vote_by voter: self.user, vote_weight: self.point
    end

    def unvote
      self.boke.unliked_by self.user
    end
end
