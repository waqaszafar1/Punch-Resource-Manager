class Api::V1::ClientsController < ApplicationController
  before_action :require_login, except: [:index, :show]
  before_action :set_client, except: [:index, :create]
  before_action :check_project, only: [:add_project, :remove_project]

  respond_to :json

  def index
    @clients = Client.all.as_json
    respond_with(@clients)
  end

  def show
    respond_with(@client.as_json)
  end

  def create
    begin
      client = Client.create(client_params)
      message, status = client.id ?
          ["Client has been created succesfully! Client: {id: #{client.id}, name: #{client.name}}", 200] :
          ["Something went wrong,Please try again after a while. Error: #{client.errors.
              full_messages.first}.}", 403]
    rescue => ex
      message, status = [ex.message, 403]
    end
    render json: {message: message}, status: status
  end

  def update
    begin
      message, status = (client_params.keys.count > 0 && @client.update_attributes(client_params)) ?
          ["Client has been updated succesfully! Client: {id: #{@client.id}, Name: #{@client.name}}", 200] :
          ["Something went wrong,Please try again after a while. Error: #{client_params.keys.count > 0 ? @client.errors.full_messages.first : 'No Matched fields to update'}", 403]
    rescue => ex
      message, status = [ex.message, 403]
    end
    render json: {message: message}, status: status
  end

  def destroy
    message, status = @client.destroy ?
        ['Client has been deleted succesfully!', 200] :
        ["Something went wrong,Please try again after a while.\n Error: #{@client.errors.full_messages.first}", 403]
    render json: {message: message}, status: status
  end

  def add_project
    unless @client.projects.find_by_id(@project)
      begin
        @client.projects << @project
        message, status = ["Project '#{@project.title}'  has been added to Client '#{@client.name}' succesfully!", 200]
      rescue => ex
        [ex.message, 403]
      end
    else
      message, status = ["This Project has already been added to the Client!", 200]
    end
    render json: {message: message}, status: status
  end

  def remove_project
    if @client.projects.find_by_id(@project)
      begin
        @client.projects.delete(@project)
        message, status = ["Project '#{@project.title}'  has been deleted from Project '#{@project.title}' succesfully!", 200]
      rescue => ex
        [ex.message, 403]
      end
    else
      message, status = ["Following project doesn't belong to this client!", 200]
    end
    render json: {message: message}, status: status
  end

  private
  def set_client
    @client = Client.find(params[:id]) rescue render_unauthorized('No such client found.')
  end

  def client_params
    params.require(:client).permit(:name)
  end

  def project_params
    params.require(:project).permit(:id)
  end


  def check_project
    @project = Project.find(project_params[:id]) rescue render_unauthorized('No such project found.')
  end
end

