class PiecesController < ApplicationController
  include TagsHelper

  def all_pieces
    @pieces = Piece.all
    @pieces.shuffle
    pull_tags(@pieces)
  end

  def index
    @artist = Artist.find(params[:artist_id])
    @pieces = @artist.pieces
  end

  def show
    @artist = Artist.find(params[:artist_id])
    @piece = Piece.find(params[:id])
    render partial: "partials/show_piece", locals: { artist: @artist, piece: @piece }
  end

  def new
    @artist = Artist.find(params[:artist_id])
  end

  def create
    @artist = Artist.find(params[:artist_id])
    @piece = @artist.pieces.new(piece_params)
    if @piece.save
      @piece.tag_list.add(params[:tag_list])
      redirect_to artist_piece_path(@artist, @piece)
    else
      render 'new'
    end
  end

  def edit
    @artist = Artist.find(params[:artist_id])
    @piece = Piece.find(params[:id])
  end

  def update
    @piece = Piece.find(params[:id])
    if @piece.update(piece_params)
      redirect_to artist_piece_path(@piece.artist_id, @piece)
    else
      render 'edit'
    end
  end

  def destroy
    @piece = Piece.find(params[:id])
    @artist = Artist.find(params[:artist_id])
    @piece.destroy
    redirect_to artist_path(@artist)
  end

  private
  def piece_params
    params.require(:piece).permit(:img, :title, :description, :tag_list, :image)
  end
end
