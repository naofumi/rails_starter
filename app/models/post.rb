class Post < ApplicationRecord
  has_many :taggings, dependent: :restrict_with_error
  has_many :tags, through: :taggings, inverse_of: :posts

  def tag_names=(tag_names)
    self.tags = split_tag_names(tag_names)
                  .map { |name| Tag.find_or_initialize_by(name: name) }
  end


  private

    def split_tag_names(tag_names)
      tag_names.split(/\s*,\s*/)
    end
end
