class Tag < ApplicationRecord
  has_many :taggings, dependent: :restrict_with_error
  has_many :posts, through: :taggings, inverse_of: :tags
end
