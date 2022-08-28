class Report < ApplicationRecord
  belongs_to :reporter, class_name: "User"
  belongs_to :reported, class_name: "User"

  validates :reason, presence:true,length:{maximum:150, minimum:10}

  enum status: { waiting: 0, keep: 1, finish: 2 }
end
