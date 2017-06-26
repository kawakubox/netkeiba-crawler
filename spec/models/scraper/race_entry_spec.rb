# frozen_string_literal: true

require 'rails_helper'

RSpec.describe Scraper::RaceEntry do
  subject { Scraper::RaceEntry.new(html) }

  let(:html) { File.read(File.join(Rails.root, 'spec/fixtures/html/race_entry.html')) }
end
