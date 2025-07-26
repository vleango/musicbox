class Components::HomeView < Components::Base
  
  def view_template
    div(class: "p-4", "x-data": "{ count: 0 }") do
      button("x-on:click": "count++") { "Increment" }
      span("x-text": "count")
    end
  end

end
