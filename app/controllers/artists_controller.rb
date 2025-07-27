class ArtistsController < ApplicationController
  def songs
    @artist = Managers::Music.new.get_artist(params[:id])

    if params[:page]
      render turbo_stream: [
        turbo_stream.replace("songs", Components::Search::Songs.new(@artist, page: params[:page])),
        turbo_stream.append("songs", "<script>window.scrollTo(0, 0);</script>".html_safe)
      ]
    else
      render turbo_stream: turbo_stream.replace("songs", Components::Search::Songs.new(@artist))
    end
  end
end
