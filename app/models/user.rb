class User < ApplicationRecord
  after_save :default_avatar
  has_one_attached :avatar
  has_many :lists, dependent: :destroy
  has_many :items, through: :lists, dependent: :destroy
  # Include default devise modules. Others available are:
  # :confirmable, :lockable, :timeoutable, :trackable and :omniauthable
  devise :database_authenticatable, :registerable,
         :recoverable, :rememberable, :validatable
	VALID_EMAIL_REGEX = /\A[\w+\-.]+@[a-z\d\-]+(\.[a-z\d\-]+)*\.[a-z]+\z/i
	validates :email, presence: true, length: { maximum: 255 },
										format: { with:	VALID_EMAIL_REGEX },
                    uniqueness: { case_sensitive: false }
  validates :name, presence: true, length: { maximum: 50 }
  validates :bio, length: { maximum: 1000 }
  validate :avatar_image

  def avatar_image
    correct_types =   %w[image/png image/jpeg]

    if avatar.attached?
      errors.add(:avatar, "must be PNG or JPEG") unless avatar.content_type.in?( correct_types )
    else
      errors.add(:avatar, "must be uploaded")
    end
  end

  def default_avatar
     unless avatar.attached?
        avatar.attach(io: File.open('app/assets/images/default-user.png'),
                      filename: 'default.png', content_type: 'image/png')
     end
  end
end
