class Api::RunnersController < ApiController
  def index
    @runners = Runner.all
  end
end
