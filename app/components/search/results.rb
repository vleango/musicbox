class Components::Search::Results < Components::Base
  def initialize(data:)
    @artists = data[:artists]
    @next_page = data[:next_page]
  end

  def view_template
    div(class: "min-h-screen p-4") do
      div(class: "w-full max-w-7xl mx-auto") {
        div(class: "flex h-full") {
          if @artists.any?
            results_found
          else
            no_results
          end
        }
      }
    end
  end

  def results_found
    div(class: "flex w-full") do
      # Left side - Artists list
      div(class: "w-1/4 border-r border-gray-200 pr-4") do
        render Components::Search::Artists.new(@artists)
      end

      # Right side - Songs for selected artist
      div(class: "flex-1 pl-6") do
        render Components::Search::Songs.new(@artists.first)
      end
    end
  end

  def no_results
    div(class: "w-full h-full flex items-center justify-center") do
      p(class: "text-gray-500") { "No artists found" }
    end
  end
end
