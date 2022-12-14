class Post < ApplicationRecord
  # paginates_per 1
  belongs_to :user
  has_many :favorites, dependent: :destroy
  has_many :post_comments, dependent: :destroy
  has_many :active_comments, -> { joins(:user).where(user: {is_deleted: false})}, class_name: "PostComment"
  #postsテーブルから中間テーブルに対する関連付け
  has_many :post_tag_relations, dependent: :destroy
  #postsテーブルから中間テーブルを介してTagsテーブルへの関連付け
  has_many :tags, through: :post_tag_relations
  scope :active, -> { joins(:user).where(user: {is_deleted: false}) }

  has_one_attached :image

  validates :title, presence:true,length:{maximum:20, minimum:2}
  validates :body, presence:true,length:{maximum:200, minimum:2}



  def favorited?(user)
   favorites.where(user_id: user.id).exists?
  end

  def get_image(width, height)
    unless image.attached?
      file_path = Rails.root.join('app/assets/images/default-image.jpeg')
      image.attach(io: File.open(file_path), filename: 'default-image.jpg', content_type: 'image/jpeg')
    end
    image.variant(resize_to_limit: [2500, 2500]).processed
  end

  def self.search(keyword,page)
    where("title like? OR body like?", "%#{keyword}%", "%#{keyword}%").page(page)
  end
end