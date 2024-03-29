# frozen_string_literal: true

require 'rails_helper'

RSpec.describe Scraper::RaceResultCell do
  let(:html) { File.read(File.join(Rails.root, 'spec/fixtures/html/yahoo_race_result_cell.html')) }
  subject { Scraper::RaceResultCell.new(html) }

  its(:race_key) { is_expected.to eq '1505021210' }
  its(:course_condition) { is_expected.to eq '01' }
  its(:order_of_finish) { is_expected.to eq 1 }
  its(:race_time) { is_expected.to eq 143.2 }
  its(:jockey_key) { is_expected.to eq '05212' }
  its(:jockey_weight) { is_expected.to eq 57 }
  its(:horse_weight) { is_expected.to eq 484 }
  its(:weight_diff) { is_expected.to eq -2 }
  its(:gate_number) { is_expected.to eq 7 }
  its(:horse_number) { is_expected.to eq 14 }
  its(:popularity) { is_expected.to eq 1 }
end
