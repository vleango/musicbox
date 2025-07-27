class Components::Search::Songs < Components::Base
  def initialize(artist)
    @songs = Managers::Music.new.get_songs(artist[:id])
    @artist = artist
  end

  def view_template
    div(id: "songs", class: "w-2/3 p-4") do
      h1(class: "text-2xl font-bold mb-6") { "#{@artist[:name]} - Songs" }

      if @songs.any?
        div(class: "space-y-3") do
          @songs.each do |song|
            div(class: "p-3 border-b border-gray-100 hover:bg-gray-50") do
              div(class: "font-medium") { song[:name] }
            end
          end
        end
      else
        div(class: "text-gray-500 italic") { "No songs found for this artist." }
      end
    end
  end
end
