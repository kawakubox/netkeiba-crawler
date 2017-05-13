require 'rails_helper'

RSpec.describe Event, type: :model do
  subject(:event) { Event.new(key: '17060101', held_on: Time.zone.today, name: '1回中山1日') }
  it { is_expected.to be_valid }
  it { is_expected.to be_invalid_on(:key).with(nil) }
  specify do
    Event.create(key: '17060101', held_on: Time.zone.today, name: '1回中山1日')
    expect(event.invalid?).to be_truthy
  end
  it { is_expected.to be_invalid_on(:held_on).with(nil) }
  it { is_expected.to be_invalid_on(:name).with(nil) }
end
