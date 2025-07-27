class Components::Search::Results < Components::Base
  def initialize(artists:)
    @artists = artists
  end

  def view_template
    div(class: "flex flex-col items-center justify-center min-h-screen p-4") do
      div(class: "w-full max-w-lg") {
        div(class: "flex h-full") {
          # Left side - Artists list
          div(class: "w-1/3 border-r border-gray-200 h-full overflow-y-auto") do
            render Components::Search::Artists.new(@artists)
          end

          # Right side - Songs for selected artist
          render Components::Search::Songs.new(@artists.first)
        }
      }
    end
  end
end
