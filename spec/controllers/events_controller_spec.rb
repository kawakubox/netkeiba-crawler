require 'rails_helper'

RSpec.describe EventsController, type: :controller do
  describe 'index' do
    subject { get :index }
    it { is_expected.to render_template :index }
  end
end
