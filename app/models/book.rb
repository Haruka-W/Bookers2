class Book < ApplicationRecord

	belongs_to :user
	validates :title, presence: true
	validates :body, presence: true, length: { maximum: 200 }
	has_many :book_comments, dependent: :destroy

	# bookをいいねする
	has_many :favorites, dependent: :destroy
    def favorited_by?(user)
      favorites.where(user_id: user.id).exists?
    end

    # 検索機能↓
    def self.searsh(searsh)
      if searsh
        Book.where(['title LILE ?', "%#{searsh}%"])
      else
        Book.all
      end
    end

end
