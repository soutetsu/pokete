# == Schema Information
#
# Table name: users
#
#  id                     :integer          not null, primary key
#  email                  :string           default(""), not null
#  encrypted_password     :string           default(""), not null
#  reset_password_token   :string
#  reset_password_sent_at :datetime
#  remember_created_at    :datetime
#  sign_in_count          :integer          default(0), not null
#  current_sign_in_at     :datetime
#  last_sign_in_at        :datetime
#  current_sign_in_ip     :inet
#  last_sign_in_ip        :inet
#  created_at             :datetime         not null
#  updated_at             :datetime         not null
#

class User < ActiveRecord::Base
  include Gravtastic
  gravtastic

  acts_as_followable
  acts_as_follower

  acts_as_voter

  has_many :themes
  has_many :bokes
  has_many :evaluations

  # Include default devise modules. Others available are:
  # :confirmable, :lockable, :timeoutable and :omniauthable
  devise :database_authenticatable, :registerable,
         :recoverable, :rememberable, :trackable, :validatable

  has_many :themes, dependent: :nullify
  has_many :bokes, dependent: :nullify
  has_many :comments, dependent: :destroy

  def self.order_by_evaluation_points
    sql = %q{
      SELECT
        users.id,
        users.email,
        SUM(bokes.cached_weighted_total) as total_point
      FROM
        users INNER JOIN bokes ON users.id=bokes.user_id
      GROUP BY
        users.id
      ORDER BY
        total_point DESC
    }
    User.find_by_sql(sql)
  end

  def total_evaluation_point
    self.bokes.inject(0) { |total, boke| total+boke.cached_weighted_total }
  end
end
