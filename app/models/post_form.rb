class PostForm
  include ActiveModel::Model

  attr_accessor :title, :content, :tag_names

  validates :title, presence: true
  validates :split_tag_names, presence: true

  delegate :persisted?, to: :post

  def initialize(attributes = nil, post: Post.new)
    @post = post
    attributes ||= default_attributes
    super(attributes)
  end

  def save
    return if invalid?

    ActiveRecord::Base.transaction do
      tags = split_tag_names.map { |name| Tag.find_or_create_by!(name: name) }
      post.update!(title: title, content: content, tags: tags)
    end
  rescue ActiveRecord::RecordInvalid
    false
  end

  def to_model
    post
  end

  private

  attr_reader :post

  def default_attributes
    {
      title: post.title,
      content: post.content,
      tag_names: post.tags.pluck(:name).join(',')
    }
  end

  def split_tag_names
    tag_names.split(/\s*,\s*/)
  end
end
