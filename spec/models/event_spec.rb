require 'rails_helper'

RSpec.describe Event, type: :model do
  let(:event) { Event.new(key: '17060101', date: Time.zone.today, name: '1回中山1日') }
  it { expect(event).to be_valid }
  it { expect(event).to be_invalid_on(:key).with(nil) }
  it { expect(event).to be_invalid_on(:date).with(nil) }
  it { expect(event).to be_invalid_on(:name).with(nil) }
end
