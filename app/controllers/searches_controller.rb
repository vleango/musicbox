class SearchesController < ApplicationController
  def artist
    data = Managers::Music.new.search_for_artists(params[:query])
    render Components::Search::Results.new(data: data)
  end
end
