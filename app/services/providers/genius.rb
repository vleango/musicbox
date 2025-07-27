module Providers
  class Genius
    URL = {
      search: "https://api.genius.com/search",
      songs: "https://api.genius.com/artists/:id/songs?page=:_page",
      artist: "https://api.genius.com/artists/:id"
    }
    def initialize
      @credentials = {
        access_token: ENV.fetch("GENIUS_CLIENT_ACCESS_TOKEN")
      }
    end

    def search_for_artists(query)
      url = URI("#{URL[:search]}?q=#{query}")
      json_response = request(url)

      if json_response.dig("meta", "status") == 200
        {
          next_page: json_response.dig("response", "next_page"),
          artists: json_response
            .dig("response", "hits")
            .map do |hit|
              {
                name: hit.dig("result", "primary_artist", "name"),
                id: hit.dig("result", "primary_artist", "id")
              }
            end.uniq
        }
      else
        {
          next_page: nil,
          data: []
        }
      end
    end

    def get_artist(artist_id)
      url = URI(URL[:artist].gsub(":id", artist_id.to_s))
      json_response = request(url)

      if json_response.dig("meta", "status") == 200
        {
          name: json_response.dig("response", "artist", "name"),
          id: json_response.dig("response", "artist", "id")
        }
      else
        {}
      end
    end

    def get_songs(artist_id, page: 1)
      url = URI(URL[:songs].gsub(":id", artist_id.to_s).gsub(":_page", page.to_s))
      json_response = request(url)

      if json_response.dig("meta", "status") == 200
        {
          next_page: json_response.dig("response", "next_page"),
          songs: json_response
            .dig("response", "songs")
            .map do |song|
              {
                name: song["title"],
                id: song["id"]
              }
            end.uniq
        }
      else
        {
          next_page: nil,
          data: []
        }
      end
    end

    private

    def request(url)
      http = Net::HTTP.new(url.host, url.port)
      http.use_ssl = true
      http.verify_mode = OpenSSL::SSL::VERIFY_NONE
      request = Net::HTTP::Get.new(url)
      request["Authorization"] = "Bearer #{@credentials[:access_token]}"
      response = http.request(request)
      JSON.parse(response.read_body)
    end
  end
end
