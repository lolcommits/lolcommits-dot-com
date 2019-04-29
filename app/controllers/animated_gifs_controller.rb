class AnimatedGifsController < ApplicationController

  def create
    gif = AnimatedGif.create(animated_gif_params)

    if gif.valid?
      render :json => gif
    else
      render :json => {:errors => gif.errors.as_json}, :status => :unprocessable_entity
    end
  end

  private
  def animated_gif_params
    params.require(:animated_gif).permit(:shas)
  end
end
