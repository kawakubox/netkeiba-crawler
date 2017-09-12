# frozen_string_literal: true

require 'rails_helper'

RSpec.describe EntryParser do
  let(:html) { html = Rails.root.join('spec/fixtures/html/201005030211_entry.html').read; html.force_encoding('euc-jp') }
  subject { EntryParser.new(html) }

  its('entries.size') { is_expected.to eq 18 }
end
