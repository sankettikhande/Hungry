class ApiController < ApplicationController
  rescue_from ActiveRecord::RecordNotFound, with: :handle_record_not_found

  def handle_record_not_found
    @message = "Record not found"
    render "api/failure"
  end
end
