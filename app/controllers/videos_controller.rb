class VideosController < ApplicationController

  before_action :set_video, only: [:show, :edit]
  #before_action :set_contest, only: [:index, :new]

  # All published videos
  def index
    @videos = Video.where( status: 'Convertido', contest_id: params[:contest_id] )
  end

  def show
  end

  def new
    @video = Video.new
    logger.debug "hola"
    logger.debug params[:contest_id]
    @video.contest_id = params[:contest_id]
  end

  def edit
  end

  def create
    @video = Video.new(video_params)

    @video.contest_id = params[:contest_id]
    @video.status = 'En proceso'

    respond_to do |format|
      if @video.save
        format.html { redirect_to '/contest/'+params[:contest_id]+'/videos/show/'+@video.id.to_s, notice: 'Video was successfully created.' }
        format.json { render :show, status: :created, location: '/contest/'+params[:contest_id]+'/videos/show/'+@video.id.to_s }
      else
        format.html { render :new }
        format.json { render json: @video.errors, status: :unprocessable_entity }
      end
    end
  end

  private
  def set_video
    @video = Video.find(params[:id])
  end

  private
  def set_contest
    @contest = Contest.find(params[:contest_id])
  end

  def video_params
    params.require(:video).permit(:filename, :description, :link_original, :user_name, :user_lastname, :user_email, :user_comments, :link_original, :contest_id)

  end
end