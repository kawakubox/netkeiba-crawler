# frozen_string_literal: true

class RacesController < ApplicationController
  def index
    @event = Event.find(params[:event_id])
    @races = Race.where(event: @event).order(:key) || []
  end

  def show
    @race = Race.find_by(key: params[:id])
    @entries = HorseResult.where(race: @race).order(:horse_number)
    @gates = HorseResult.where(race: @race).group(:gate_number).count(:id)
    @gate_manager = GateManager.new(@entries.count)
  end
end
