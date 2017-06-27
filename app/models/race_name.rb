# frozen_string_literal: true

class RaceName < ApplicationRecord
  before_validation :shorten_name

  private

  def shorten_name
    self.short_name = long_name.dup
    delete_pattern.each { |ptn| short_name.gsub!(ptn, '') }
    replace_pattern.each { |ptn, str| short_name.gsub!(ptn, str) }
  end

  def delete_pattern
    [/サラ系/, /ジャンプ/, /(［.+］)/]
  end

  def replace_pattern
    [
      [/万円以下/, '万下'],
      [/ハンデキャップ/, 'HC'],
      [/オープン/, 'OP'],
      [/ハンデ/, 'H'],
      [/カップ/, 'C'],
      [/ステークス/, 'S'],
      [/トロフィー/, 'T'],
      [/プレミアム/, 'P']
    ]
  end
end
