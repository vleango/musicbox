class SearchesController < ApplicationController
  def artist
    @artists = Managers::Music.new.search_for_artists(params[:query])

    render Components::Search::Results.new(artists: @artists)
  end
end
