class AlbumsController < ApplicationController
  before_action :set_album, only: [:show, :update, :destroy]
  before_action :check_secret, only: [:update, :destroy]

  # GET /albums
  def index
    @albums = Album.all

    render json: @albums
  end

  # GET /albums/1
  def show
    render json: @album
  end

  # POST /albums
  def create
    @album = Album.new(album_params)

    if @album.save
      render json: @album, status: :created, location: @album
    else
      render json: @album.errors, status: :unprocessable_entity
    end
  end

  # PATCH/PUT /albums/1
  def update
    if @album.update(album_params)
      render json: @album
    else
      render json: @album.errors, status: :unprocessable_entity
    end
  end

  # DELETE /albums/1
  def destroy
    @album.destroy
  end

  private
    # Use callbacks to share common setup or constraints between actions.
    def set_album
      @album = Album.where(identifier: params[:identifier]).first
    end

    # Only allow a trusted parameter "white list" through.
    def album_params
      params.require(:album).permit(:title, :description, :private, :images => [])
    end

    # Override for image creation
    def create_album_params
      album_params.merge(params.merge({secret: request.headers["X-Image-Secret"]}))
    end

    # Secret to provide for update/delete
    def check_secret
      render json: {message: 'Secret missing or invalid'}, status: :forbidden  unless request.headers["X-Image-Secret"] == @album.secret
    end
end
