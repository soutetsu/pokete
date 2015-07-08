# == Schema Information
#
# Table name: themes
#
#  id          :integer          not null, primary key
#  category_id :integer
#  created_at  :datetime         not null
#  updated_at  :datetime         not null
#  user_id     :integer
#  uri         :string           not null
#

class Theme < ActiveRecord::Base
  paginates_per 5

  belongs_to :user
  belongs_to :category

  has_many :bokes, dependent: :destroy

  validates :category_id, presence: true, numericality: { only_integer: true, greater_than: 0 }
  validates :uri, presence: true
end
