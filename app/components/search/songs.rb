class Components::Search::Songs < Components::Base
  def initialize(artist, page: 1)
    data = Managers::Music.new.get_songs(artist[:id], page: page)
    @artist = artist
    @songs = data[:songs]
    @next_page = data[:next_page]
  end

  def view_template
    div(id: "songs", class: "w-2/3 p-4") do
      h1(class: "text-2xl font-bold mb-6") { "#{@artist[:name]} - Songs" }

      if @songs.any?
        div(class: "space-y-3") do
          @songs.each do |song|
            div(class: "p-3 border-b border-gray-100 hover:bg-gray-50") do
              div(class: "font-medium") { song[:name] }
              div(class: "text-xs text-gray-400") { song[:id] }
            end
          end
        end
      else
        div(class: "text-gray-500 italic") { "No songs found for this artist." }
      end

      if @next_page
        div(class: "mt-6") do
          link_to(
            songs_artist_path(@artist[:id], page: @next_page),
            class: "text-blue-500 hover:underline",
            data: {
              turbo_prefetch: "false",
              turbo_stream: "true"
            },
          ) { "Load more songs" }
        end
      end
    end
  end
end
