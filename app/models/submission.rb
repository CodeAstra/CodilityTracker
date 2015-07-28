# == Schema Information
#
# Table name: submissions
#
#  id         :integer          not null, primary key
#  url        :string
#  user_id    :integer
#  created_at :datetime         not null
#  updated_at :datetime         not null
#

class Submission < ActiveRecord::Base
  belongs_to :user

  validates :url, presence: true
  validates :user, presence: true
end
