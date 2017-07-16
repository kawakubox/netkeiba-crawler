# frozen_string_literal: true

class RacesController < ApplicationController
  def index
    @event = Event.find_by(key: params[:event_id])
    @races = Race.where(event: @event).order(:key) || []
  end

  def show
    @race = Race.find_by(key: params[:id])
    @entries = HorseResult.includes(:jockey, :race, horse: %i[sire mare])
                          .where(race: @race)
                          .order(:horse_number)
    @gate_manager = GateManager.new(@entries.count)
    @races = @race.event.races.order(:key)
  end
end
