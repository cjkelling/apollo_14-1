require 'rails_helper'

describe 'Astronaut Show Page' do
  before(:each) do
    @astronaut_1 = Astronaut.create!(name: 'Neil Armstrong', age: 37, job: 'Commander')
    @astronaut_2 = Astronaut.create!(name: 'Bob Jones', age: 31, job: 'Pilot')
  end

  it 'lists all astronauts and their information' do
    visit '/astronauts'

    expect(page).to have_content(@astronaut_1.name)
    expect(page).to have_content(@astronaut_1.age)
    expect(page).to have_content(@astronaut_1.job)

    expect(page).to have_content(@astronaut_2.name)
    expect(page).to have_content(@astronaut_2.age)
    expect(page).to have_content(@astronaut_2.job)
    save_and_open_page
  end
end
