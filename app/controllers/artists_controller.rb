class ArtistsController < ApplicationController
  include ArtistsHelper
  before_action :find_artist, only: [:show, :edit, :update, :destroy]

  def find_artist
    @artist = Artist.find_by(id: params[:id])
  end

  def index
    @artists = Artist.all
    @organization = Organization.find_by(id: session[:organization_id])
  end

  def user_location
  end

  def local_artists
    @lat = [params[:lat]]
    @long = [params[:lng]]
    @artists =  Artist.near([params[:lat], params[:lng]], 5)
  end

  def show
    @pieces = @artist.pieces
    @citystate = @artist.address.scan(/(.+?),\s*(.+?)(?:,\s|\s\s)(.+?)\s(\d{5})/)
    @location= @citystate[0][1] + ", " + @citystate[0][2]
  end

  def new
    @artist = Artist.new
  end

  def create
    @artist = Artist.new(artist_params)
    if @artist.save
      redirect_to artist_path(@artist)
    else
      render 'new'
    end
  end

  def edit
  end

  def update
    if @artist.update(artist_params)
      redirect_to artist_path
    else
      render 'edit'
    end
  end

  def destroy
    @artist.destroy
    redirect_to root_path
  end

  private

  def artist_params
    params.require(:artist).permit(:name, :email, :password, :address, :facebook, :twitter, :website, :bio, :avatar)
  end
end
