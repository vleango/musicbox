module Providers
  class FakeApi
    def search_for_artists(query)
      [
        { name: "#{query} 1", id: 1 },
        { name: "#{query} 2", id: 2 },
        { name: "#{query} 3", id: 3 }
      ]
    end

    def get_artist(artist_id)
      { name: "Artist #{artist_id}", id: artist_id }
    end

    def get_songs(artist_id)
      [
        { name: "Song 1 by #{artist_id}", id: 1 },
        { name: "Song 2 by #{artist_id}", id: 2 },
        { name: "Song 3 by #{artist_id}", id: 3 }
      ]
    end
  end
end
