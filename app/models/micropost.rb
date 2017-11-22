class Micropost < ApplicationRecord
  belongs_to :user
  has_many :likes, dependent: :destroy

  default_scope -> { order(created_at: :desc) }
  mount_uploader :picture, PictureUploader
  validates :user_id, presence: true
  validates :content, presence: true, length: { maximum: 140 }
  validate  :picture_size

  def self.search(search) #ここでのself.はMicropost.を意味する
    if search
      where(['content LIKE ?', "%#{search}%"]) #検索とcontentの部分一致を表示。Micropost.は省略。
    else
      all #全て表示。Micropost.は省略。
    end
  end
  
  #likeマークをつける
  def like_user(user_id)
   likes.find_by(user_id: user_id)
  end

  private

    # アップロードされた画像のサイズをバリデーションする
    def picture_size
      if picture.size > 5.megabytes
        errors.add(:picture, "should be less than 5MB")
      end
    end
end
