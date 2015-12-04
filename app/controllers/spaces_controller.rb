class SpacesController < ApplicationController
  before_action :find_organization, except: [:all_spaces]
  before_action :find_space, only: [:show, :edit, :update, :destroy]

  def find_organization
    @organization = Organization.find(params[:organization_id])
  end

  def find_space
    @space = Space.find(params[:id])
  end

  def all_spaces
    @spaces = Space.all
    half = @spaces.length
    @first_half = @spaces[0..half]
    @second_half = @spaces[half..-1]
  end

  def index
    @spaces = Organization.find_by(id: params[:organization_id]).spaces
  end

  def show
    render partial: "partials/show_space", locals: { space: @space }
  end

  def new
    @space = Space.new
  end

  def create
    @artist = Artist.find_by(email: params[:artist_id])
    @space = Space.new( space_params )
      if @space.save
        @artist.spaces << @space
        @organization.spaces << @space
        redirect_to organization_space_path(@organization, @space)
      else
        render 'new'
      end
  end

  def edit
  end

  def update
    if @space.update(space_params)
      redirect_to organization_space_path(@organization, @space)
    else
      render 'edit'
    end
  end

  def destroy
    @space.destroy
    redirect_to organization_path(@organization)
  end

  private

  def space_params
    params.require(:space).permit(:img, :title, :description, :image)
  end
end
