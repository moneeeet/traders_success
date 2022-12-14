class Tag < ApplicationRecord
  #Tagsテーブルから中間テーブルに対する関連付け
  has_many :post_tag_relations, dependent: :destroy
  #Tagsテーブルから中間テーブルを介してpostテーブルへの関連付け
  has_many :posts, through: :post_tag_relations, dependent: :destroy

  validates :name, presence:true,length:{maximum:10}

end
