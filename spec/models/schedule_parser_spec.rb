# frozen_string_literal: true

require 'rails_helper'

RSpec.describe ScheduleParser do
  let(:html) { File.read(File.join(Rails.root, 'spec/fixtures/html/yahoo_schedule.html')) }
  subject { ScheduleParser.new(html) }

  its('events.size') { is_expected.to eq 24 }
  context 'when shedule page uncompleted' do
    let(:html) { File.read(File.join(Rails.root, 'spec/fixtures/html/yahoo_schedule_uncomplete.html')) }
    its('events.size') { is_expected.to eq 22 }
  end

  its(:events) { is_expected.to all(be_a(Event)) }
  its('events.first') do
    is_expected.to have_attributes(
      key:     '17060101',
      held_on: Date.new(2017, 1, 5),
      name:    '1回中山1日'
    )
  end

  its('events.last') do
    is_expected.to have_attributes(
      key:     '17080202',
      held_on: Date.new(2017, 1, 29),
      name:    '2回京都2日'
    )
  end
end
