# frozen_string_literal: true

require 'rails_helper'

RSpec.describe GateManager do
  describe 'gates' do
    it { expect(GateManager.new(1).gates).to eq({ 1 => [1], 2 => [], 3 => [], 4 => [], 5 => [], 6 => [], 7 => [], 8 => [] }) }
    it { expect(GateManager.new(8).gates).to eq({ 1 => [1], 2 => [2], 3 => [3], 4 => [4], 5 => [5], 6 => [6], 7 => [7], 8 => [8] }) } 
    it { expect(GateManager.new(9).gates).to eq({ 1 => [1], 2 => [2], 3 => [3], 4 => [4], 5 => [5], 6 => [6], 7 => [7], 8 => [8, 9] }) } 
    it { expect(GateManager.new(16).gates).to eq({ 1 => [1, 2], 2 => [3, 4], 3 => [5, 6], 4 => [7, 8], 5 => [9, 10], 6 => [11, 12], 7 => [13, 14], 8 => [15, 16] }) } 
    it { expect(GateManager.new(17).gates).to eq({ 1 => [1, 2], 2 => [3, 4], 3 => [5, 6], 4 => [7, 8], 5 => [9, 10], 6 => [11, 12], 7 => [13, 14], 8 => [15, 16, 17] }) } 
    it { expect(GateManager.new(18).gates).to eq({ 1 => [1, 2], 2 => [3, 4], 3 => [5, 6], 4 => [7, 8], 5 => [9, 10], 6 => [11, 12], 7 => [13, 14, 15], 8 => [16, 17, 18] }) } 
  end
end
