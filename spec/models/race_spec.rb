require 'rails_helper'

RSpec.describe Race, type: :model do
  subject { Race.new(key: '1505021210', ordinal: 82, name: '東京優駿', grade: :g1, distance: 2400, weather: :sunny, course_condition: :good) }

  it { is_expected.to be_valid }
  it { is_expected.to be_invalid_on(:key).with(nil) }
  it { is_expected.to be_invalid_on(:key).with('150502121') }
  it { is_expected.to be_invalid_on(:key).with('15050212101') }

  it { is_expected.to be_valid_on(:ordinal).with(nil) }
  it { is_expected.to be_invalid_on(:ordinal).with(0) }
  it { is_expected.to be_valid_on(:ordinal).with(1) }
  it { is_expected.to be_invalid_on(:ordinal).with(1.1) }

  it { is_expected.to be_valid_on(:name).with(nil) }
  it { is_expected.to be_invalid_on(:name).with('') }

  it { is_expected.to be_valid_on(:grade).with(nil) }
  it { is_expected.to be_invalid_on(:grade).with(:g4) }

  it { is_expected.to be_valid_on(:distance).with(nil) }
  it { is_expected.to be_invalid_on(:distance).with(999) }
  it { is_expected.to be_valid_on(:distance).with(1000) }

  it { is_expected.to be_invalid_on(:weather).with(:windy) }

  it { is_expected.to be_invalid_on(:course_condition).with(:bad) }

  its(:yahoo_race_entry_url) { is_expected.to eq 'https://keiba.yahoo.co.jp/race/denma/1505021210/?page=2' }
end
