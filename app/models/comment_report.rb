class CommentReport < ApplicationRecord
  belongs_to :comment_reporter, class_name: "User"
  belongs_to :comment_reported, class_name: "User"
  belongs_to :post_comment, optional: true

  validates :reason, presence:true

  enum comment_report_status: { waiting: 0, keep: 1, finish: 2 }
end
