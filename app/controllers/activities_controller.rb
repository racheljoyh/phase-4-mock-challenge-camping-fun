class ActivitiesController < ApplicationController
  rescue_from ActiveRecord::RecordNotFound, with: :render_not_found
  before_action :set_activity, only: [:show, :update, :destroy]
 


  # GET /activities
  def index
    @activities = Activity.all

    render json: @activities
  end

   def show
    render json: @activity
  end


  # DELETE /activities/1
  def destroy
    @activity.destroy
  end

  private
    # Use callbacks to share common setup or constraints between actions.
    def set_activity
      @activity = Activity.find(params[:id])
    end

  def render_not_found
      render json: {error: "Activity not found"}, status: :not_found
    end 



    
end
