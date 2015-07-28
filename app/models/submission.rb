# == Schema Information
#
# Table name: submissions
#
#  id                  :integer          not null, primary key
#  url                 :string
#  user_id             :integer
#  created_at          :datetime         not null
#  updated_at          :datetime         not null
#  codility_session_id :string
#  task_title          :string
#  correctness         :integer
#  performance         :integer
#  task_score          :integer
#

require 'mechanize'

class Submission < ActiveRecord::Base
  belongs_to :user

  validates :url, presence: true
  validates :user, presence: true

  after_create :evaluate_submission

private
  def evaluate_submission
    mechanize = Mechanize.new
    page = mechanize.get(self.url)
    self.task_title = get_tag_content(page, 'a#task-0-name')
    self.codility_session_id = get_tag_content(page, '#ticket-id')
    self.correctness = get_tag_content(page, 'table.task-scores tr:nth-child(2) > td:nth-child(2) span.number')
    self.performance = get_tag_content(page, 'table.task-scores tr:nth-child(2) > td:nth-child(3) span.number')
    self.task_score = get_tag_content(page, '#total-result > b')
    self.save
  end

  def get_tag_content(page, tag_selector)
    page.at(tag_selector).try(:text).try(:strip)
  end
end
