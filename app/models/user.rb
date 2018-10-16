class User < ApplicationRecord
  after_save :default_avatar
  has_one_attached :avatar
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
    avatar_type = 
    if self.avatar.attached?
      errors.add(:avatar, "must be PNG or JPEG") unless self.avatar.content_type.in?( correct_types )
    elsif
      errors.add(:avatar, "must be uploaded")
    end
  end

  def default_avatar
     unless self.avatar.attached?
         self.avatar.attach(io: File.open('app/assets/images/default-user.png'),
                           filename: 'default.png', content_type: 'image/png')
     end
  end
end
