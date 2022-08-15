class CommentReport < ApplicationRecord
  belongs_to :comment_reporter, class_name: "User"
  belongs_to :comment_reported, class_name: "User"

  enum status: { waiting: 0, keep: 1, finish: 2 }
end
