class OrganizationsController < ApplicationController
  before_action :find_organization, only: [:show, :edit, :update, :destroy]

  def find_organization
    @organization = Organization.find_by(id: params[:id])
  end

  def index
  end

  def show
    @spaces = @organization.spaces
    @citystate = @organization.address.scan(/(.+?),\s*(.+?)(?:,\s|\s\s)(.+?)\s(\d{5})/)
    @location= @citystate[0][1] + ", " + @citystate[0][2]
  end

  def new
    @organization = Organization.new
  end

  def create
    @organization = Organization.new(organization_params)
    if @organization.save
      redirect_to organization_path(@organization)
    else
      render 'new'
    end
  end

  def edit
  end

  def update
    if @organization.update(organization_params)
      redirect_to organization_path
    else
      render 'edit'
    end
  end

  def destroy
    @organization.destroy
    redirect_to root_path
  end

  private

  def organization_params
    params.require(:organization).permit(:name, :email, :password, :address, :facebook, :twitter, :website, :bio, :avatar, :latitude, :longitude)
  end
end
