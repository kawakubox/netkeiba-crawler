# frozen_string_literal: true

class EventsController < ApplicationController
  def index
    today = Time.zone.today
    @year = params[:year]&.to_i || today.year
    @month = params[:month]&.to_i || today.month
    date = Date.new(@year, @month)
    @events = Event.where(held_on: month_period(date)).order(:held_on)
  end

  private

  def month_period(date)
    date.beginning_of_month..date.end_of_month
  end
end
