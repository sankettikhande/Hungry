class ApiController < ApplicationController
  after_filter do |controller|
    if controller.params[:callback] && controller.params[:format].to_s == 'json'
      controller.response['Content-Type'] = 'application/javascript'
      controller.response.body = "%s(%s)" % [controller.params[:callback], controller.response.body]
    end
  end

  rescue_from ActiveRecord::RecordNotFound, with: :handle_record_not_found

  def handle_record_not_found
    @message = "Record not found"
    render "api/failure"
  end
end
