class PostComment < ApplicationRecord
  belongs_to :user
  belongs_to :post
  has_many :comment_reports

  validates :comment, presence:true,length:{maximum:150, minimum:2}
end
