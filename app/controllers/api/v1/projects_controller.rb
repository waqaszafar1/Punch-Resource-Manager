class Api::V1::ProjectsController < ApplicationController
  before_action :require_login, except: [:index, :show]
  before_action :set_project, except: [:index, :create]
  before_action :check_employee, only: [:add_employee, :remove_employee]

  respond_to :json

  def index
    @projects = Project.all
    respond_with(@projects)
  end

  def show
    respond_with(@project)
  end

  def create
    begin
      project = Project.create(project_params)
      message, status = project.id ?
          ["Project has been created succesfully! Project: {id: #{project.id}, title: #{project.title}}", 200] :
          ["Something went wrong,Please try again after a while. Error: #{project.errors.
              full_messages.first}.}", 403]
    rescue => ex
      message, status = [ex.message, 403]
    end
    render json: {message: message}, status: status
  end

  def update
    begin
      message, status = (project_params.keys.count > 0 && @project.update_attributes(project_params)) ?
          ["Project has been updated succesfully! Project: {id: #{@project.id}, title: #{@project.title}}", 200] :
          ["Something went wrong,Please try again after a while. Error: #{project_params.keys.count > 0 ? @project.errors.full_messages.first : 'No Matched fields to update'}", 403]
    rescue => ex
      message, status = [ex.message, 403]
    end
    render json: {message: message}, status: status
  end

  def destroy
    message, status = @project.destroy ?
        ['Project has been deleted succesfully!', 200] :
        ["Something went wrong,Please try again after a while.\n Error: #{@project.errors.full_messages.first}", 403]
    render json: {message: message}, status: status
  end

  def add_employee
    unless @project.employees.find_by_id(@employee)
      begin
        @project.employees << @employee
        message, status = ["Employee '#{@employee.name}'  has been added to Project '#{@project.title}' succesfully!", 200]
      rescue => ex
        [ex.message, 403]
      end
    else
      message, status = ["This Employee has already been added to the Project!", 200]
    end
    render json: {message: message}, status: status
  end

  def remove_employee
    if @project.employees.find_by_id(@employee)
      begin
        @project.employees.delete(@employee)
        message, status = ["Employee '#{@employee.name}'  has been deleted from Project '#{@project.title}' succesfully!", 200]
      rescue => ex
        [ex.message, 403]
      end
    else
      message, status = ["Following employee doesn't belong to this project!", 200]
    end
    render json: {message: message}, status: status
  end

  private
  def set_project
    @project = Project.find(params[:id]) rescue render_unauthorized('No such project found.')
  end

  def project_params
    params.require(:project).permit(:title)
  end

  def employee_params
    params.require(:employee).permit(:id)
  end

  def check_employee
    @employee = Employee.find(employee_params[:id]) rescue render_unauthorized('No such employee found.')
  end
end

