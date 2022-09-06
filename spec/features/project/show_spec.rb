require 'rails_helper'

RSpec.describe 'project show' do
  before :each do
    @recycled_material_challenge = Challenge.create(theme: 'Recycled Material', project_budget: 1000)
    @furniture_challenge = Challenge.create(theme: 'Apartment Furnishings', project_budget: 1000)

    @news_chic = @recycled_material_challenge.projects.create(name: 'News Chic', material: 'Newspaper')
    @boardfit = @recycled_material_challenge.projects.create(name: 'Boardfit', material: 'Cardboard Boxes')

    @upholstery_tux = @furniture_challenge.projects.create(name: 'Upholstery Tuxedo', material: 'Couch')
    @lit_fit = @furniture_challenge.projects.create(name: 'Litfit', material: 'Lamp')

    @jay = Contestant.create(name: 'Jay McCarroll', age: 40, hometown: 'LA', years_of_experience: 13)
    @gretchen = Contestant.create(name: 'Gretchen Jones', age: 36, hometown: 'NYC', years_of_experience: 12)
    @kentaro = Contestant.create(name: 'Kentaro Kameyama', age: 30, hometown: 'Boston', years_of_experience: 8)
    @erin = Contestant.create(name: 'Erin Robertson', age: 44, hometown: 'Denver', years_of_experience: 15)

    ContestantProject.create(contestant_id: @jay.id, project_id: @news_chic.id)
    ContestantProject.create(contestant_id: @gretchen.id, project_id: @news_chic.id)
    ContestantProject.create(contestant_id: @gretchen.id, project_id: @upholstery_tux.id)
    ContestantProject.create(contestant_id: @kentaro.id, project_id: @upholstery_tux.id)
    ContestantProject.create(contestant_id: @kentaro.id, project_id: @boardfit.id)
    ContestantProject.create(contestant_id: @erin.id, project_id: @boardfit.id)

    visit "/projects/#{@news_chic.id}"
  end

  it 'describes name and material' do
    expect(page).to have_content(@news_chic.name)
    expect(page).to have_content(@news_chic.material)
  end

  it 'shows the challenge theme' do
    expect(page).to have_content(@recycled_material_challenge.theme)
  end

  it 'shows a count of the contestants per project' do 
    within "#contestant-count" do
      expect(page).to have_content('Contestants: 2')
    end

    visit "/projects/#{@upholstery_tux.id}"
    within "#contestant-count" do
      expect(page).to have_content('Contestants: 2')
    end

    visit "/projects/#{@boardfit.id}"
    within "#contestant-count" do
      expect(page).to have_content('Contestants: 2')
    end

    visit "/projects/#{@lit_fit.id}"
    within "#contestant-count" do
      expect(page).to have_content('Contestants: 0')
    end
  end

  it 'shows avg experience of contestants working on proj' do 
    within "#avg-exp" do
      expect(page).to have_content("#{(@jay.years_of_experience + @gretchen.years_of_experience)/2} years")
    end
  end
end
