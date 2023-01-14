class SignupsController < ApplicationController
  rescue_from ActiveRecord::RecordInvalid, with: :render_unprocessable_entity
  before_action :set_signup, only: [:show, :update, :destroy]

  # GET /signups
  def index
    @signups = Signup.all

    render json: @signups
  end

  # GET /signups/1
  def show
    render json: @signup
  end

  # POST /signups
  def create
    @signup = Signup.new(signup_params)

    if @signup.save!
      render json: @signup.activity, status: :created
    else
      render json: @signup.errors, status: :unprocessable_entity
    end
  end


  private
    # Use callbacks to share common setup or constraints between actions.
    def set_signup
      @signup = Signup.find(params[:id])
    end

    # Only allow a list of trusted parameters through.
    def signup_params
      params.permit(:time, :camper_id, :activity_id)
    end

    def render_unprocessable_entity(exception)
      render json: { errors: exception.record.errors.full_messages }, status: :unprocessable_entity
    end
end
