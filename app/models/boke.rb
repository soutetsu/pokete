# == Schema Information
#
# Table name: bokes
#
#  id                      :integer          not null, primary key
#  theme_id                :integer
#  content                 :string           not null
#  created_at              :datetime         not null
#  updated_at              :datetime         not null
#  user_id                 :integer
#  cached_votes_total      :integer          default(0)
#  cached_votes_score      :integer          default(0)
#  cached_votes_up         :integer          default(0)
#  cached_weighted_score   :integer          default(0)
#  cached_weighted_total   :integer          default(0)
#  cached_weighted_average :float            default(0.0)
#

class Boke < ActiveRecord::Base
  acts_as_taggable
  acts_as_votable

  paginates_per 5

  STANDARD_HALL_OF_FAME = {
    vote_averate: 3.0,
    voter_count: 2
  }

  belongs_to :user
  belongs_to :theme

  has_many :evaluations, dependent: :destroy

  validates :theme_id, presence: true, numericality: { only_integer: true, greater_than: 0 }
  validates :content, presence: true

  scope :hall_of_fame, ->{
    where{
      (cached_weighted_average.gteq STANDARD_HALL_OF_FAME[:vote_averate]) &
      (cached_weighted_total.gteq STANDARD_HALL_OF_FAME[:voter_count])
    }
  }

  def has_evaluated_by?(user)
    self.evaluations.find_by(user: user).present?
  end
end
