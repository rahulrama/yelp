class Restaurant < ActiveRecord::Base

  has_many :reviews, dependent: :destroy do
    def build_with_user(attributes = {}, user)
      attributes[:user] ||= user
      build(attributes)
    end
  end

  belongs_to :user

  validates :name, length: { minimum: 3 }, uniqueness: true



end
