class Api::V1::OperationsController < ApplicationController
  before_action :set_operation, only: [:show, :update, :destroy]

  # GET /operations
  def index
    per_page = params[:per_page] ? params[:per_page] : 10
    @operations = Operation.all.paginate(page: params[:page], per_page: per_page)

    if @operations.length >= 1
      render json: {
        status: 'SUCCESS',
        menssage: 'Successfully',
        data: @operations,
        per_page: per_page.to_i,
        total_data: @operations.count,
        current_page: params[:page].to_i ? params[:page].to_i : 0,
        total_pages: @operations.total_pages
      },
      include: {
        customers: { except: [:created_at, :updated_at] }
      }
    else
      per_page  = 0
      total_pages = 0
      render json: {
        status: 'SUCCESS',
        menssage: 'There are no customers registered in this page',
        data: [],
        per_page: per_page.to_i,
        total_data: @operations.count,
        current_page: params[:page].to_i ? params[:page].to_i : 0,
        total_pages: @operations.total_pages
      }
    end
  end

  # GET /operations/1
  def show
    render json: @operation
  end

  # POST /operations
  def create
    binding.pry
    @operation = Operation.new(operation_params)

    if @operation.save
      render json: {
        data: @operation,
        status: "SUCCESS",
        message: 'Saved as successfully',
        location: api_v1_operation_url(@operation)
      }
    else
      render json: @operation.errors, status: :unprocessable_entity
    end
  end

  # PATCH/PUT /operations/1
  def update
    if @operation.update(operation_params)
      render json: @operation
    else
      render json: @operation.errors, status: :unprocessable_entity
    end
  end

  # DELETE /operations/1
  def destroy
    @operation.destroy
  end

  private
    # Use callbacks to share common setup or constraints between actions.
    def set_operation
      @operation = Operation.find(params[:id])
    end

    # Only allow a list of trusted parameters through.
    def operation_params
      params.require(:operation).permit(:description)
    end
end
