# frozen_string_literal: true

class RacesController < ApplicationController
  def index
    @event = Event.find(params[:event_id])
    @races = Race.where(event: @event).order(:id) || []
  end

  def show
    @race = Race.find(params[:id])
    @entries = HorseResult.includes(:jockey, :race, horse: %i[sire mare])
                          .where(race: @race)
                          .order(:horse_number)
    @gate_manager = GateManager.new(@entries.count)
    @races = @race.event.races.order(:id)
  end
end
