class Post < ApplicationRecord
  has_many :taggings, dependent: :restrict_with_error
  has_many :tags, through: :taggings, inverse_of: :posts
end
