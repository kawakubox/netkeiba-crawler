# frozen_string_literal: true

require 'rails_helper'

RSpec.describe Scraper::RaceResultTimeCell do
  let(:html) { File.read(File.join(Rails.root, 'spec/fixtures/html/yahoo_race_result_time_cell.html')) }
  subject { Scraper::RaceResultTimeCell.new(html) }

  its(:race_key) { is_expected.to eq '1505021210' }
  its(:course_condition) { is_expected.to eq '01' }
  its(:order_of_finish) { is_expected.to eq 1 }
  its(:last_3f) { is_expected.to eq 33.9 }
  its(:corner_position) { is_expected.to eq '08-08-08-07' }
end
