class User < ApplicationRecord
  # Include default devise modules. Others available are:
  # :confirmable, :lockable, :timeoutable, :trackable and :omniauthable
  devise :database_authenticatable, :registerable,
         :recoverable, :rememberable, :validatable

  has_many :posts, dependent: :destroy
  has_many :favorites, dependent: :destroy
  has_many :post_comments, dependent: :destroy
  has_many :reports, class_name: "Report", foreign_key: "reporter_id", dependent: :destroy
  has_many :reverse_of_reports, class_name: "Report", foreign_key: "reported_id", dependent: :destroy
  has_one_attached :profile_image
  # has_many :comment_reports, class_name: "CommentReport", foreign_key: "comment_reporter_id", dependent: :destroy
  # has_many :reverse_of_comment_reports, class_name: "CommentReport", foreign_key: "comment_reprted_id", dependent: :destroy

  def get_profile_image(width, height)
    unless profile_image.attached?
      file_path = Rails.root.join('app/assets/images/default-image.jpeg')
      profile_image.attach(io: File.open(file_path), filename: 'default-image.jpg', content_type: 'image/jpeg')
    end
    profile_image.variant(resize_to_limit: [100, 100]).processed
  end

   def self.guest
    find_or_create_by!(name: 'guestuser' ,email: 'guest@example.com') do |user|
      user.password = SecureRandom.urlsafe_base64
      user.name = "guestuser"
    end
   end

  def active_for_authentication?
    super && (self.is_deleted == false)
  end
end
