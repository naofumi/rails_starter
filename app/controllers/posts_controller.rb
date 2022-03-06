class PostsController < ApplicationController
  # GET /posts or /posts.json
  def index
    @posts = Post.all
  end

  # GET /posts/new
  def new
    @post = Post.new
  end

  # POST /posts or /posts.json
  def create
    tags = tags(post_params[:tag_names])
    @post = Post.new(post_params.except(:tag_names).merge(tags: tags))

    if @post.save
      redirect_to posts_path, notice: "Post was successfully created."
    else
      render :new
    end
  end

  # GET /posts/1/edit
  def edit
    load_post
  end


  # PATCH/PUT /posts/1 or /posts/1.json
  def update
    load_post
    @post.tags = tags(post_params[:tag_names])

    if @post.update(post_params.except(:tag_names))
      redirect_to @post, notice: "Post was successfully updated."
    else
      render :edit
    end
  end

  private

    # Only allow a list of trusted parameters through.
    def post_params
      params.require(:post).permit(:title, :content, :tag_names)
    end

    def load_post
      @post = Post.find(params[:id])
    end

    def tags(tag_names_string)
      split_tag_names(tag_names_string)
                        .map { |name| Tag.find_or_initialize_by(name: name) }
    end

    def split_tag_names(tag_names_string)
      tag_names_string.split(/\s*,\s*/)
    end
end
