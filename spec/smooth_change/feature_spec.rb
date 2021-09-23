# frozen_string_literal: true

require_relative "../spec_helper"

RSpec.describe SmoothChange::Feature do
  subject(:feature) { described_class.new(name, mode) }

  describe ".new" do
    context "with valid arguments" do
      let(:name) { "feature1" }
      let(:mode) { :opt_in }

      it "assign attributes" do
        expect(feature).to have_attributes(name: "feature1", mode: :opt_in)
      end
    end

    context "with string mode" do
      let(:name) { "feature1" }
      let(:mode) { "opt_in" }

      it "converts mode to symbol" do
        expect(feature).to have_attributes(name: "feature1", mode: :opt_in)
      end
    end

    context "with invalid arguments" do
      let(:name) { "feature1" }
      let(:mode) { :invalid }

      it "assign attributes" do
        expect { feature }.to raise_exception(ArgumentError)
      end
    end
  end

  describe "#default_enabled_value" do
    let(:name) { "feature1" }

    context "when :opt_in" do
      let(:mode) { :opt_in }

      it { is_expected.to have_attributes(default_enabled_value: false) }
    end

    context "when :opt_out" do
      let(:mode) { :opt_out }

      it { is_expected.to have_attributes(default_enabled_value: true) }
    end
  end

  describe ".new" do
    context "with valid arguments" do
      let(:name) { "feature1" }
      let(:mode) { :opt_in }

      it "assign attributes" do
        expect(feature).to have_attributes(name: "feature1", mode: :opt_in)
      end
    end

    context "with string mode" do
      let(:name) { "feature1" }
      let(:mode) { "opt_in" }

      it "converts mode to symbol" do
        expect(feature).to have_attributes(name: "feature1", mode: :opt_in)
      end
    end

    context "with invalid arguments" do
      let(:name) { "feature1" }
      let(:mode) { :invalid }

      it "assign attributes" do
        expect { feature }.to raise_exception(ArgumentError)
      end
    end
  end

  describe "#default_enabled_value" do
    let(:name) { "feature1" }

    context "when :opt_in" do
      let(:mode) { :opt_in }

      it { is_expected.to have_attributes(default_enabled_value: false) }
    end

    context "when :opt_out" do
      let(:mode) { :opt_out }

      it { is_expected.to have_attributes(default_enabled_value: true) }
    end
  end
end
