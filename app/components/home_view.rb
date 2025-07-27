class Components::HomeView < Components::Base
  def view_template
    div(class: "flex flex-col items-center justify-center min-h-screen p-4") do
      div(class: "w-full max-w-lg") do
        render Components::Search.new
      end
    end
  end
end
