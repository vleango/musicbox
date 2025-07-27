require 'rails_helper'

RSpec.feature "HomePage", type: :feature do
  scenario "visiting the home page" do
    visit root_path

    expect(page).to have_http_status(:success)
    expect(page).to have_css('h1', text: 'Welcome to MusicBox')
  end

  describe "searching for artists" do
    context "when results are found" do
      let!(:artist) { { id: 1, name: "Test Artist" } }
      let!(:song) { { id: 1, name: "Test Song", artist: artist } }

      before do
        allow_any_instance_of(Managers::Music).to receive(:search_for_artists)
          .with("Test").and_return({ next_page: nil, artists: [ artist ] })
        allow_any_instance_of(Managers::Music).to receive(:get_artist)
          .with(artist[:id].to_s).and_return(artist)
        allow_any_instance_of(Managers::Music).to receive(:get_songs)
          .with(artist[:id], page: 1).and_return({ next_page: nil, songs: [ song ] })
      end

      it "displays the search results and allows viewing songs" do
        visit root_path

        fill_in "query", with: "Test"
        click_button "Search"

        find("#artist_1").click
        expect(page.body).to include(song[:name])
      end
    end

    context "when no results are found" do
      before do
        allow_any_instance_of(Managers::Music).to receive(:search_for_artists)
          .with("Nonexistent").and_return({ next_page: nil, artists: [] })
      end

      it "shows a no results message" do
        visit root_path

        fill_in "query", with: "Nonexistent"
        click_button "Search"

        expect(page.body).to include("No artists found")
      end
    end
  end
end
