# frozen_string_literal: true

require 'rails_helper'

RSpec.describe EntryRowParser do
  let(:html) do
    <<~HTML
      <tr class="bml1">
        <td class="waku8"><span>8</span></td>
        <td class="umaban">17</td>
        <diary_snap_cut>
        <td>&nbsp;</td>
        </diary_snap_cut>
        <diary_snap_cut>
        </diary_snap_cut>
        <td class="txt_l horsename">
          <div>
            <a href="http://db.netkeiba.com/horse/2007103234/" target="_blank" title="アパパネ">アパパネ</a>
          </div>
        </td>
        <td>牝3</td>
        <td>55.0</td>
        <td class="txt_l"><a href="http://db.netkeiba.com/jockey/00663/" target="_blank" title="蛯名">蛯名</a></td>
        <td class="txt_l"><a href="http://db.netkeiba.com/trainer/00399/" target="_blank" title="国枝">国枝</a></td>
        <td class="txt_l">470(-10)</td>
        <td class="txt_r">3.8</td>
        <td class="r1ml">1</td>
        <diary_snap_cut>
        <td class="txt_nowrap"></td>
        <td class="txt_l">&nbsp;</td>
        </diary_snap_cut>
      </tr>
    HTML
  end
  subject { EntryRowParser.new(html) }

  its(:gate_number) { is_expected.to eq 8 }
  its(:horse_number) { is_expected.to eq 17 }
  its(:horse) { is_expected.to be_a Horse }
  its(:sex) { is_expected.to eq :female }
  its(:age) { is_expected.to eq 3 }
  its(:jockey_weight) { is_expected.to eq 55.0 }
  its(:jockey) { is_expected.to be_a Jockey }
  its(:trainer) { is_expected.to be_a Trainer }
  its(:horse_weight) { is_expected.to eq [470, -10] }
  its(:popularity) { is_expected.to eq 1 }
end
