class CreateCommentReports < ActiveRecord::Migration[6.1]
  def change
    create_table :comment_reports do |t|
      t.integer :comment_reporter_id, null: false
      t.integer :comment_reported_id, null: false
      t.text :reason, null: false
      t.text :url
      t.integer :comment_report_status, default: 0, null: false
      t.integer :post_comment_id, null: false, foreign_key: true

      t.timestamps
    end
  end
end
