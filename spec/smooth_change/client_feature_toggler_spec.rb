# frozen_string_literal: true

require_relative "../spec_helper"

RSpec.describe SmoothChange::ClientFeatureToggler do
  describe ".from_http_header" do
    subject(:client_configuration) { described_class.from_http_header(http_header_value) }

    context "basic header" do
      let(:http_header_value) { "feature1,!feature2" }

      it "enable feature1" do
        expect(client_configuration.value_for(:feature1)).to eq(true)
      end

      it "disable feature2" do
        expect(client_configuration.value_for(:feature2)).to eq(false)
      end

      it "disable feature3" do
        expect(client_configuration.value_for(:feature3)).to eq(nil)
      end
    end

    context "with spaces" do
      let(:http_header_value) { " feature1 , !feature2" }

      it "enable feature1" do
        expect(client_configuration.value_for(:feature1)).to eq(true)
      end

      it "disable feature2" do
        expect(client_configuration.value_for(:feature2)).to eq(false)
      end

      it "disable feature3" do
        expect(client_configuration.value_for(:feature3)).to eq(nil)
      end
    end
  end

  describe "#value_for" do
    subject(:client_configuration) do
      described_class.new({ feature1: true, feature2: false })
    end

    it "returns true if enabled" do
      expect(client_configuration.value_for(:feature1)).to eq(true)
    end

    it "returns false if disabled" do
      expect(client_configuration.value_for(:feature2)).to eq(false)
    end

    it "returns nil if unknown" do
      expect(client_configuration.value_for(:feature3)).to eq(nil)
    end

    it "accepts strings" do
      expect(client_configuration.value_for("feature1")).to eq(true)
    end
  end
end
