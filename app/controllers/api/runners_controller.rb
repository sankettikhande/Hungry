class Api::RunnersController < ApiController
  def index
    @runners = Runner.all
  end

  def orders
    @runner = Runner.find(params[:runner_id], include: [:orders])
    @orders = @runner.orders
    render "api/orders/index"
  end
end
