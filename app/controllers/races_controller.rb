# frozen_string_literal: true

class RacesController < ApplicationController
  def index
    @event = Event.find(params[:event_id])
    @races = Race.where(event: @event).order(:key) || []
  end

  def show
    @race = Race.find(params[:id])
    @entries = @race.horse_results.order(:horse_number)
    @gate_manager = GateManager.new(@entries.count)
  end
end
