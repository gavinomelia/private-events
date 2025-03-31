class EventAttendancesController < ApplicationController
  before_action :authenticate_user!

  def create
    @event = Event.find_by(id: params[:event_id])
    unless @event
      redirect_to events_path, alert: "Event not found." and return
    end

    @event_attendance = EventAttendance.new
    @event_attendance.attended_event_id = @event.id
    @event_attendance.attendee_id = current_user.id

    if @event_attendance.save
      redirect_to event_path(@event_attendance.attended_event), notice: "You are now attending this event."
    else
      redirect_to event_path(@event), alert: "Unable to attend the event."
    end
  end

  def destroy
    @attendance = current_user.event_attendances.find_by(attended_event_id: params[:event_id])
    @event = Event.find_by(id: params[:event_id])

    if @attendance&.destroy
      redirect_to @event || events_path, notice: "You are no longer attending this event."
    else
      redirect_to @event || events_path, alert: "Error removing attendance."
    end
  end

  private

  def event_attendance_params
    params.fetch(:event_attendance, {})
  end
end
