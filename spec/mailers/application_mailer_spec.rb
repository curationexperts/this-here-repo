# frozen_string_literal: true
require 'rails_helper'

RSpec.describe ApplicationMailer do
  it { expect(described_class).to be < ActionMailer::Base }
end
