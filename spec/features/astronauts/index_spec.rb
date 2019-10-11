require 'rails_helper'

describe 'Astronaut Show Page' do
  before(:each) do
    @astronaut_1 = Astronaut.create!(name: 'Neil Armstrong', age: 37, job: 'Commander')
    @astronaut_2 = Astronaut.create!(name: 'Bob Jones', age: 31, job: 'Pilot')

    @a_mission = Mission.create!(title: 'A Mission', time_in_space: 365)
    @b_mission = Mission.create!(title: 'B Mission', time_in_space: 98)
    @c_mission = Mission.create!(title: 'C Mission', time_in_space: 182)
    @d_mission = Mission.create!(title: 'D Mission', time_in_space: 25)

    AstronautMission.create!(mission_id: @a_mission.id, astronaut_id: @astronaut_1.id)
    AstronautMission.create!(mission_id: @c_mission.id, astronaut_id: @astronaut_2.id)
    AstronautMission.create!(mission_id: @d_mission.id, astronaut_id: @astronaut_1.id)
    AstronautMission.create!(mission_id: @b_mission.id, astronaut_id: @astronaut_2.id)
    visit '/astronauts'
  end

  it 'lists all astronauts and their information' do
    within "#astronaut-#{@astronaut_1.id}" do
      expect(page).to have_content(@astronaut_1.name)
      expect(page).to have_content(@astronaut_1.age)
      expect(page).to have_content(@astronaut_1.job)
    end

    within "#astronaut-#{@astronaut_2.id}" do
      expect(page).to have_content(@astronaut_2.name)
      expect(page).to have_content(@astronaut_2.age)
      expect(page).to have_content(@astronaut_2.job)
    end
  end

  it 'shows the average age of all astronauts' do
    expect(page).to have_content('Average Age: 34')
  end

  it 'shows a list of space missions, in alphabetical order, for each astronaut' do
    within "#astronaut-#{@astronaut_1.id}" do
      expect(page).to have_content('Missions: A Mission, D Mission')
    end

    within "#astronaut-#{@astronaut_2.id}" do
      expect(page).to have_content('Missions: B Mission, C Mission')
    end
  end

  it 'I see the total time in space for each astronaut' do
    visit '/astronauts'

    within "#astronaut-#{@astronaut_1.id}" do
      expect(page).to have_content('Total Time in Space: 390 days')
    end

    within "#astronaut-#{@astronaut_2.id}" do
      expect(page).to have_content('Total Time in Space: 280 days')
    end
    save_and_open_page
  end
end
