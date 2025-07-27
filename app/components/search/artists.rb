class Components::Search::Artists < Components::Base
  def initialize(artists, selected_artist = artists.first)
    @artists = artists
    @selected_artist = selected_artist
  end

  def view_template
    div("x-data": alpine_data) {
      h1(class: "text-2xl font-bold mb-4 p-4") { "Artists" }

      div(class: "divide-y divide-gray-200") {
        template("x-for": "artist in artists", ":key": "artist.id") {
          a("x-bind:href": "`/artists/${artist.id}/songs.turbo_stream`",
            "x-bind:class": "{
              'block p-4 hover:bg-gray-50': true,
              'bg-blue-50': isSelected(artist.id)
            }",
            "x-on:click": "selectArtist(artist.id)",
            "data-turbo-prefetch": "false",
            "data-turbo-stream": "true",
            "data-turbo-frame": "songs") {
            div(class: "font-semibold", "x-text": "artist.name")
          }
        }
      }
    }
  end

  def alpine_data
    <<~JS
      {
        artists: #{@artists.to_json},
        selectedArtistId: #{@selected_artist&.dig(:id).to_json},
        isSelected(artistId) { return this.selectedArtistId === artistId },
        selectArtist(artistId) { this.selectedArtistId = artistId }
      }
    JS
  end
end
