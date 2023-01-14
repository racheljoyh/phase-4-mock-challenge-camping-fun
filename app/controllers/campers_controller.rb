class CampersController < ApplicationController
  before_action :set_camper, only: [:show, :update, :destroy]
  rescue_from ActiveRecord::RecordInvalid, with: :render_unprocessable_entity
  rescue_from ActiveRecord::RecordNotFound, with: :render_not_found

  # GET /campers
  def index
    @campers = Camper.all

    render json: @campers
  end

  # GET /campers/1
  def show
    render json: @camper, serializer: CamperActivitiesSerializer
  end

  # POST /campers
  def create
    @camper = Camper.create!(camper_params)
    render json: @camper, status: :created
   
  end

  # PATCH/PUT /campers/1
  def update
      @camper.update!(camper_params)
      render json: @camper
   
  end

  # DELETE /campers/1
  def destroy
    @camper.destroy
  end

  private
    # Use callbacks to share common setup or constraints between actions.
    def set_camper
      @camper = Camper.find(params[:id])
    end

    # Only allow a list of trusted parameters through.
    def camper_params
      params.permit(:name, :age)
    end

    def render_unprocessable_entity(exception)
      render json: { errors: exception.record.errors.full_messages }, status: :unprocessable_entity
    end

    def render_not_found
      render json: {error: "Camper not found"}, status: :not_found
    end 
end
