class Api::V1::CustomersController < ApplicationController
  before_action :set_customer, only: [:show, :update, :destroy]

  # GET /customers
  def index
    @customers = Customer.all

    render json: @customers
  end

  # GET /customers/1
  def show
    render json: @customer
  end

  # POST /customers
  def create
    @customer = Customer.new(customer_params)

    if @customer.save
      render json: {
        data: @customer,
        status: 'SUCCESS',
        message: 'Saved as successfully',
        location: api_v1_customer_url(@customer)
      },
      include: [
        {operations: {except: [:created_at, :updated_at]}}
      ]
    else
      render json: @customer.errors, status: :unprocessable_entity
    end
  end

  # PATCH/PUT /customers/1
  def update
    if @customer.update(customer_params)
      render json: @customer
    else
      render json: @customer.errors, status: :unprocessable_entity
    end
  end

  # DELETE /customers/1
  def destroy
    @customer.destroy
  end

  private
    # Use callbacks to share common setup or constraints between actions.
    def set_customer
      @customer = Customer.find(params[:id])
    end

    # Only allow a list of trusted parameters through.
    def customer_params
      params.require(:customer)
      .permit(
        :fantasyName,
        :customerName,
        :taxId,
        :status,
        :stateRegistration,
        :facility_id,
        :contact_id,
        operation_ids: []
      )
    end
end
