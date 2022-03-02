class PostsController < ApplicationController
  # GET /posts/new
  def new
    @form = PostForm.new
  end

  # POST /posts or /posts.json
  def create
    @form = PostForm.new(post_params)

    if @form.save
      redirect_to posts_path, notice: "Post was successfully created."
    else
      render :new
    end
  end

  # GET /posts/1/edit
  def edit
    load_post

    @form = PostForm.new(post: @post)
  end


  # PATCH/PUT /posts/1 or /posts/1.json
  def update
    load_post

    @form = PostForm.new(post_params, post: @post)

    if @form.save
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
