class Api::V1::EmployeesController < ApplicationController
  before_action :require_login, except: [:index, :show]
  before_action :set_employee, except: [:index, :create]

  respond_to :json

  def index
    @employees = Employee.all.as_json
    respond_with(@employees)
  end

  def show
    respond_with(@employee.as_json)
  end

  def create
    begin
      employee = Employee.create(employee_params)
      message, status = employee.id ?
          ["Employee has been created succesfully! Employee: {id: #{employee.id}, name: #{employee.name}, designation: #{employee.designation}}", 200] :
          ["Something went wrong,Please try again after a while. Error: #{employee.errors.
              full_messages.first}.", 403]
    rescue => ex
      message, status = [ex.message, 403]
    end
    render json: {message: message}, status: status
  end

  def update
    begin
      message, status = (employee_params.keys.count > 0 && @employee.update_attributes(employee_params)) ?
          ["Employee has been updated succesfully! Employee: {id: #{@employee.id}, name: #{@employee.name}, designation: #{@employee.designation}}", 200] :
          ["Something went wrong,Please try again after a while. Error: #{employee_params.keys.count > 0 ? @employee.errors.full_messages.first : 'No Matched field to update'}", 403]
    rescue => ex
      message, status = [ex.message, 403]
    end
    render json: {message: message}, status: status
  end

  def destroy
    message, status = @employee.destroy ?
        ['Employee has been deleted succesfully!', 200] :
        ["Something went wrong,Please try again after a while.\n Error: #{@employee.full_messages}", 403]
    render json: {message: message}, status: status
  end

  private
  def set_employee
    @employee = Employee.find(params[:id]) rescue render_unauthorized('No such employee found.')
  end

  def employee_params
    params.require(:employee).permit(:name, :designation)
  end
end

