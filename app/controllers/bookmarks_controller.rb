class BookmarksController < ApplicationController
  before_action :set_bookmark, only: [:show, :edit, :update, :destroy]
  skip_before_action :verify_authenticity_token, if: :json_request?

  # GET /bookmarks
  # GET /bookmarks.json
  def index
    @bookmarks = Bookmark.all.includes(:user, :tags).order(updated_at: :desc).page(params[:page])
  end

  # GET /bookmarks/1
  # GET /bookmarks/1.json
  def show
    authorize @bookmark
  end

  # GET /bookmarks/new
  def new
    @bookmark = Bookmark.new
    authorize @bookmark
  end

  # GET /bookmarks/1/edit
  def edit
    authorize @bookmark
  end

  # POST /api/posts/add.json
  def add_bookmark
    user = User.find_by(api_token: params["token"])
    puts "found #{user} with api_token #{params['token']}"
    Rails.logger.info "found #{user&.username} with api_token #{params['token']}"
    @bookmark = Bookmark.find_or_initialize_by(user_id: user.id, address: params[:url] )
    bookmark_params[:address] = params[:url]
    @bookmark.update!(bookmark_params)

    Rails.logger.info "updated #{@bookmark} with api_token #{params['api_token']}"
    render {}
  end

  # POST /bookmarks
  # POST /bookmarks.json
  def create
    @bookmark = Bookmark.find_or_initialize_by(user_id: bookmark_params[:user_id], address: bookmark_params[:address] ).tap do |b|
                  b.update(bookmark_params)
                end
    authorize @bookmark

    respond_to do |format|
      if @bookmark
        format.html { redirect_to bookmark_path @bookmark, is_popup: @bookmark.is_popup, notice: 'Bookmark was successfully created in bookmarks controller.' }
        format.json { render :show, status: :created, location: @bookmark }
      else
        format.html { render :new }
        format.json { render json: @bookmark.errors, status: :unprocessable_entity }
      end
    end
  end

  # PATCH/PUT /bookmarks/1
  # PATCH/PUT /bookmarks/1.json
  def update
    authorize @bookmark
    respond_to do |format|
      if @bookmark.update(bookmark_params)
        format.html { redirect_to bookmark_path @bookmark, is_popup: @bookmark.is_popup, notice: 'Bookmark was successfully updated.' }
        format.json { render :show, status: :ok, location: @bookmark }
      else
        format.html { render :edit }
        format.json { render json: @bookmark.errors, status: :unprocessable_entity }
      end
    end
  end

  # DELETE /bookmarks/1
  # DELETE /bookmarks/1.json
  def destroy
    authorize @bookmark
    @bookmark.destroy
    respond_to do |format|
      format.html { redirect_to bookmarks_url, notice: 'Bookmark was successfully destroyed.' }
      format.json { head :no_content }
    end
  end

  def search
    @q = Bookmark.ransack(title_cont: params[:q])
    @bookmarks = @q.result(distinct: true).order(updated_at: :DESC).page(params[:page])
  end

  private

  # Use callbacks to share common setup or constraints between actions.
  def set_bookmark
    @bookmark = Bookmark.find(params[:id])
  end

  # Never trust parameters from the scary internet, only allow the white list through.
  def bookmark_params
    params.require(:bookmark).permit(:url, :address, :hashed_url, :user_id, :description, :title, :private, :is_archived, :archive_url, :tag_list, :is_popup)
  end

  
  def json_request?
    request.format.json?
  end
end
