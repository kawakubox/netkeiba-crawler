# frozen_string_literal: true

require 'rails_helper'

RSpec.describe Race, type: :model do
  subject { FG.build :race }

  it { is_expected.to respond_to :event }
  it { is_expected.to be_valid }
  it { is_expected.to be_invalid_on(:key).with(nil) }
  it { is_expected.to be_invalid_on(:key).with('150502121') }
  it { is_expected.to be_invalid_on(:key).with('15050212101') }
  context 'when race key already stored' do
    let(:race) { FG.create :race }
    it { is_expected.to be_invalid_on(:key).with(race.key) }
  end

  it { is_expected.to be_valid_on(:ordinal).with(nil) }
  it { is_expected.to be_invalid_on(:ordinal).with(0) }
  it { is_expected.to be_valid_on(:ordinal).with(1) }
  it { is_expected.to be_invalid_on(:ordinal).with(1.1) }

  it { is_expected.to be_valid_on(:name).with(nil) }
  it { is_expected.to be_invalid_on(:name).with('') }

  it { is_expected.to be_valid_on(:grade).with(nil) }
  it { expect { subject.grade = :g4 }.to raise_error ArgumentError }

  it { is_expected.to be_valid_on(:distance).with(nil) }
  it { is_expected.to be_invalid_on(:distance).with(999) }
  it { is_expected.to be_valid_on(:distance).with(1000) }

  it { expect { subject.weather = :windy }.to raise_error ArgumentError }

  it { expect { subject.course_condition = :bad }.to raise_error ArgumentError }

  its(:yahoo_race_entry_url) do
    subject.key = '1505021210'
    is_expected.to eq 'https://keiba.yahoo.co.jp/race/denma/1505021210/?page=2'
  end

  describe 'before_save' do
    it 'create event' do
      expect { Race.create!(key: '1234567890') }
        .to change { Event.find('12345678') }.from(nil).to(be_present)
    end
  end
end
