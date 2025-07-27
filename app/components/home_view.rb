class Components::HomeView < Components::Base
  def view_template
    div(class: "flex flex-col items-center justify-center min-h-screen p-4") do
      div(class: "w-full max-w-lg") do
        h1(class: "text-3xl font-bold text-center mb-8") { "Welcome to MusicBox" }
        render Components::Search.new
      end
    end
  end
end
