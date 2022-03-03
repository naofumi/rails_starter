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
    @post = Post.new(post_params)

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

    if @post.update(post_params)
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
end
