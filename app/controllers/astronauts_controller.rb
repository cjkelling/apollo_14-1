class AstronautsController<ApplicationController
  def index
    @astronauts = Astronaut.all
    @astronaut_missions = AstronautMission.all
  end
end
