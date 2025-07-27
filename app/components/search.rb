class Components::Search < Components::Base
  def view_template
    div(class: "p-4") do
      form(
        action: artist_searches_path,
        method: :get,
        class: "w-full"
      ) {
        div(class: "flex gap-2") do
          input(
            type: "text",
            name: "query",
            class: "px-4 py-2 border rounded-md flex-grow",
            placeholder: "Search artists..."
          )
          button(
            type: "submit",
            class: "px-4 py-2 bg-blue-500 text-white rounded-md hover:bg-blue-600 cursor-pointer"
          ) { "Search" }
        end
      }
    end
  end
end
