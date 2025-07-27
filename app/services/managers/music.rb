module Managers
  class Music
    delegate :search_for_artists, :get_artist, :get_songs, to: :@client

    def initialize
      @client = Providers::Genius.new
    end
  end
end
