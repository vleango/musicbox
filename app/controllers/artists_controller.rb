class ArtistsController < ApplicationController

  def songs
    @artist = Managers::Music.new.get_artist(params[:id])
    render turbo_stream: turbo_stream.replace("songs", Components::Search::Songs.new(@artist))
  end

end
