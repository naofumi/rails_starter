class PostForm
  include ActiveModel::Model

  attr_accessor :title, :content, :tag_names
  attr_reader :post

  validates :title, presence: true
  validates :split_tag_names, presence: true

  delegate :title, :title=, :content, :content=,
           :persisted?, :to_model, :save,
           to: :post

  def initialize(attributes = nil, post: Post.new)
    @post = post
    super(attributes)
  end

  def tag_names=(tag_names_string)
    post.tags = split_tag_names(tag_names_string)
                  .map { |name| Tag.find_or_initialize_by(name: name) }
  end

  def tag_names
    post.tags.pluck(:name).join(',')
  end

  private

  def split_tag_names(tag_names_string)
    tag_names_string.split(/\s*,\s*/)
  end
end
