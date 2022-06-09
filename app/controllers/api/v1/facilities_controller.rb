class Api::V1::FacilitiesController < ApplicationController
  before_action :set_facility, only: [:show, :update, :destroy]

  # GET /facilities
  def index
    per_page = params[:per_page] ? params[:per_page] : 10
    @facilities = Facility.all.paginate(page: params[:page], per_page: per_page)

    if @facilities.length >= 1
      render json: {
        status: 'SUCCESS',
        menssage: 'Successfully',
        data: @facilities,
        per_page: per_page.to_i,
        total_data: @facilities.count,
        current_page: params[:page].to_i ? params[:page].to_i : 0,
        total_pages: @facilities.total_pages
      },
      include: {
        customer: { except: [:created_at, :updated_at] }
      }
    else
      per_page  = 0
      total_pages = 0
      render json: {
        status: 'SUCCESS',
        menssage: 'There are no facilities registered in this page',
        data: [],
        per_page: per_page.to_i,
        total_data: @facilities.count,
        current_page: params[:page].to_i ? params[:page].to_i : 0,
        total_pages: @facilities.total_pages
      }
    end
  end

  # GET /facilities/1
  def show
    render json: @facility
  end

  # POST /facilities
  def create
    @facility = Facility.new(facility_params)

    if @facility.save
      render json: {
        data:  @facility,
        status: 'SUCCESS',
        message: 'Saved as successfully',
        location: api_v1_facility_url(@facility)
      },
      include: {
        customer: { except: [:createad_at, :updated_at] }
      }
    else
      render json: @facility.errors, status: :unprocessable_entity
    end
  end

  # PATCH/PUT /facilities/1
  def update
    if @facility.update(facility_params)
      render json: @facility
    else
      render json: @facility.errors, status: :unprocessable_entity
    end
  end

  # DELETE /facilities/1
  def destroy
    @facility.destroy
  end

  private
    # Use callbacks to share common setup or constraints between actions.
    def set_facility
      @facility = Facility.find(params[:id])
    end

    # Only allow a list of trusted parameters through.
    def facility_params
      params.require(:facility).permit(
        :cep,
        :complement,
        :number,
        :city,
        :state,
        :country,
        :description,
        :customer_id)
    end
end
