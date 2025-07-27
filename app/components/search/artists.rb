class Components::Search::Artists < Components::Base
  def initialize(artists, selected_artist = artists.first)
    @artists = artists
    @selected_artist = selected_artist
  end

  def view_template
    div("x-data": alpine_data) {
      h1(class: "text-2xl font-bold mb-4 p-4") { "Artists" }

      div(class: "divide-y divide-gray-200") {
        @artists.each do |artist|
          link_to(
            songs_artist_path(artist[:id]),
            id: "artist_#{artist[:id]}",
            data: {
              turbo_prefetch: "false",
              turbo_stream: "true"
            },
            class: "block p-4 hover:bg-gray-50",
            "x-bind:class": "isSelected(#{artist[:id]}) ? 'bg-blue-50' : ''",
            "x-on:click": "selectArtist(#{artist[:id]})",
          ) {
            div(class: "font-semibold") { artist[:name] }
          }
        end
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
