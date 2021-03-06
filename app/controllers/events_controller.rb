class EventsController < ApplicationController

  before_action :ensure_staff?, except: [:show, :index]

  def index
    @events = current_course.events.order("due_at ASC")
  end

  def show
    @event = current_course.events.find(params[:id])
  end

  def new
    @event = current_course.events.new
  end

  def edit
    @event = current_course.events.find(params[:id])
  end

  def copy
    event = current_course.events.find(params[:id])
    duplicated = event.copy
    redirect_to events_path, notice: "Event #{duplicated.name} was successfully created"
  end

  def create
    @event = current_course.events.new(event_params)
    if @event.save
      flash[:notice] = "Event #{@event.name} was successfully created"
      respond_with(@event)
    else
      render :new
    end
  end

  def update
    @event = current_course.events.find(params[:id])
    flash[:notice] = "Event #{@event.name} was successfully updated" if @event.update(event_params)
    respond_with(@event)
  end

  def destroy
    @event = current_course.events.find(params[:id])
    @name = @event.name
    @event.destroy
    redirect_to events_url, notice: "#{@name} successfully deleted"
  end

  private

  def event_params
    params.require(:event).permit(:course_id, :name, :description, :open_at,
    :due_at, :media, :remove_media)
  end
end
