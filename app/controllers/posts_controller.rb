class PostsController < ApplicationController
  layout 'simple'

  before_action :set_post, only: %i[ show edit update destroy ]

  before_action :set_users

  # GET /posts or /posts.json
  def index
    @posts = Post.all
  end

  # GET /posts/1 or /posts/1.json
  def show
  end

  # GET /posts/new
  def new
    @post = Post.new
  end

  # GET /posts/1/edit
  def edit
  end

  # POST /posts or /posts.json
  def create
    @post = Post.new(post_params)
    respond_to do |format|
      result = PostInteractors::UpdatePost.call(
        additional_params: { action: params[:commit], moderator_id: post_params[:moderator_id] },
        post: @post,
        params: post_params
      )
      if result.success?
        format.html { redirect_to @post, notice: "Post was successfully created." }
        format.json { render :show, status: :created, location: @post }
      else
        format.html { render :new, status: :unprocessable_entity }
        format.json { render json: @post.errors, status: :unprocessable_entity }
      end
    end
  end

  # PATCH/PUT /posts/1 or /posts/1.json
  def update
    respond_to do |format|
      result = PostInteractors::UpdatePost.call(
        additional_params: { action: params[:commit], moderator_id: post_params[:moderator_id], cancellation_reason: post_params[:cancellation_reason] },
        post: @post,
        params: post_params
      )

      if result.success?
        format.html { redirect_to @post, notice: "Post was successfully updated." }
        format.json { render :show, status: :ok, location: @post }
      else
        format.html { render :edit, status: :unprocessable_entity }
        format.json { render json: @post.errors, status: :unprocessable_entity }
      end
    end
  end

  # DELETE /posts/1 or /posts/1.json
  def destroy
    @post.destroy
    respond_to do |format|
      format.html { redirect_to posts_url, notice: "Post was successfully destroyed." }
      format.json { head :no_content }
    end
  end

  private
  # Use callbacks to share common setup or constraints between actions.
  #
  def set_post
    @post = Post.find(params[:id])
  end

  # Only allow a list of trusted parameters through.
  def post_params
    params.require(:post).permit(:user_id, :scheduled_at, :moderator_id, :title, :body, :cancellation_reason)
  end

  def set_users
    @users = Profile.includes(:user)
    @current_user = User.find_by(is_admin: false)
  end

end