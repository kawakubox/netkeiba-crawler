# frozen_string_literal: true

class GateManager
  attr_reader :total, :gates

  def initialize(total)
    @total = total
    @gates = { 1 => [], 2 => [], 3 => [], 4 => [], 5 => [], 6 => [], 7 => [], 8 => [] }
    nums = (1..total).to_a
    gate_capacities.each.with_index(1) do |i, idx|
      i.times { @gates[idx] << nums.shift }
    end
  end

  def ordinal(horse_number)
    raise StandardError if total < horse_number
    @gates.each_pair do |gate, nums|
      break nums.index(horse_number) if nums.include? horse_number
    end
  end

  def head_of_gate?(horse_number)
    ordinal(horse_number).zero?
  end

  private

  def gate_capacities
    capacities = [0, 0, 0, 0, 0, 0, 0, 0]
    (1..total).each do |i|
      idx = total <= 8 ? i - 1 : (i % 8) * -1
      capacities[idx] = capacities[idx] + 1
    end
    capacities
  end
end
