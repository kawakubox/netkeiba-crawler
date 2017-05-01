require 'rails_helper'

RSpec.describe Scraper::RaceResult do
  let(:html) { File.read(File.join(Rails.root, 'spec/fixtures/html/yahoo_race_result_cell.html')) }
  subject { Scraper::RaceResult.new(html) }

  its(:race_key) { is_expected.to eq '1505021210' }
  its(:course_condition) { is_expected.to eq '01' }
  its(:order) { is_expected.to eq 1 }
  its(:race_time) { is_expected.to eq 143.2 }
end
