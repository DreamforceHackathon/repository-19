class ResponsesController < ApplicationController
  before_action :redirect_to_root_unless_user_signed_in

  def destroy
    @response = Response.find(params[:id])
    authorize @response

    @response.destroy
    flash[:notice] = "The response was destroyed."
    redirect_to request.referer
  end

end
