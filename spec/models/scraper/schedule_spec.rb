# frozen_string_literal: true

require 'rails_helper'

RSpec.describe Scraper::Schedule do
  let(:html) { File.read(File.join(Rails.root, 'spec/fixtures/html/yahoo_schedule.html')) }
  subject { Scraper::Schedule.new(html) }

  its('scrape.size') { is_expected.to eq 24 }
  context 'when shedule page uncompleted' do
    let(:html) { File.read(File.join(Rails.root, 'spec/fixtures/html/yahoo_schedule_uncomplete.html')) }
    its('scrape.size') { is_expected.to eq 22 }
  end

  its(:scrape) { is_expected.to all(be_a(Event)) }
  its('scrape.first') do
    is_expected.to have_attributes(
      key: '17060101',
      date: Date.new(2017, 1, 5),
      name: '1回中山1日'
    )
  end
  its('scrape.last') do
    is_expected.to have_attributes(
      key: '17080202',
      date: Date.new(2017, 1, 29),
      name: '2回京都2日'
    )
  end
end
