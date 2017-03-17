class ImagesController < ApplicationController
  before_action :set_image, only: [:show, :update, :destroy]
  before_action :check_secret, only: [:update, :destroy]

  # GET /images
  def index
    @images = Image.all.limit(params[:limit] || 20)
    render json: @images
  end

  # GET /images/1
  def show
    render json: @image
  end

  # POST /images
  def create
    @image = Image.new(create_image_params)
    if @image.save
      render json: @image.as_json(only: [:secret]), status: :created, location: @image
    else
      p @image.errors
      render json: @image.errors, status: :unprocessable_entity
    end
  end

  # PATCH/PUT /images/1
  def update
    if @image.update(image_params)
      render json: @image
    else
      byebug
      render json: @image.errors, status: :unprocessable_entity
    end
  end

  # DELETE /images/1
  def destroy
    @image.destroy
  end

  private
    # Use callbacks to share common setup or constraints between actions.
    def set_image
      @image = Image.where(identifier: params[:identifier]).first
    end

    # Only allow a trusted parameter "white list" through.
    def image_params
      params.require(:image).permit(:title, :description, :private)
    end

    # Override for image creation
    def create_image_params
      image_params.merge(params.require(:image).permit(:image, :remote_image_url, :secret))
    end

    # Secret to provide for update/delete
    def check_secret
      render json: {message: 'Secret missing or invalid'}, status: :forbidden  unless request.headers["X-Image-Secret"] == @image.secret
    end
end

