# frozen_string_literal: true

require 'rails_helper'

RSpec.describe Event, type: :model do
  subject(:event) { Event.new(id: '17060101', held_on: Time.zone.today, name: '1回中山1日') }

  it { is_expected.to respond_to :races }
  it { is_expected.to be_valid }
  it { is_expected.to be_valid_on(:held_on).with(nil) }
  it { is_expected.to be_valid_on(:name).with(nil) }
end
