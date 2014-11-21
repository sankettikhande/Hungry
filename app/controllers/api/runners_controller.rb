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
    authenticated = (!runner.blank? && params[:password] == Base64.decode64(runner.password))
    response_hash = { "is_authenticated" => authenticated }
    response_hash.merge!(runner: {id: runner.id, name: runner.name}) if runner and authenticated
    render :json => response_hash
  end

end
