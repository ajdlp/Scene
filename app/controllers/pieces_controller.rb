class PiecesController < ApplicationController
  include TagsHelper
  before_action :find_artist, except: [:all_pieces, :update]
  before_action :find_piece, only: [:show, :edit, :update, :destroy]

  def find_artist
    @artist = Artist.find(params[:artist_id])
  end

  def find_piece
    @piece = Piece.find(params[:id])
  end

  def all_pieces
    @pieces = Piece.all
    @pieces.shuffle
    pull_tags(@pieces)
  end

  def index
    @pieces = @artist.pieces
  end

  def show
    render partial: "partials/show_piece", locals: { artist: @artist, piece: @piece }
  end

  def new
  end

  def create
    @piece = @artist.pieces.new(piece_params)
    if @piece.save
      @piece.tag_list.add(params[:tag_list])
      redirect_to artist_piece_path(@artist, @piece)
    else
      render 'new'
    end
  end

  def edit
  end

  def update
    if @piece.update(piece_params)
      redirect_to artist_piece_path(@piece.artist_id, @piece)
    else
      render 'edit'
    end
  end

  def destroy
    @piece.destroy
    redirect_to artist_path(@artist)
  end

  private
  def piece_params
    params.require(:piece).permit(:img, :title, :description, :tag_list, :image)
  end
end
