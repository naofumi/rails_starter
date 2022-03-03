class Post < ApplicationRecord
  has_many :taggings, dependent: :restrict_with_error
  has_many :tags, through: :taggings, inverse_of: :posts

  def tag_names=(tag_names_string)
    self.tags = split_tag_names(tag_names_string)
                  .map { |name| Tag.find_or_initialize_by(name: name) }
  end


  private

    def split_tag_names(tag_names_string)
      tag_names_string.split(/\s*,\s*/)
    end
end
