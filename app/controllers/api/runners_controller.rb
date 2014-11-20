class Api::RunnersController < ApiController

  def index
    @runners = Runner.includes(:orders).all
  end

  def orders
    @runner = Runner.find(params[:runner_id], include: [:orders])
    @orders = @runner.orders
    render "api/orders/index"
  end

  def authenticate_runner
    runner = Runner.where(username:params[:username]).first
    render :json => { "is_authenticated" => runner ? params[:password] == Base64.decode64(runner.password) : false }
  end

end
