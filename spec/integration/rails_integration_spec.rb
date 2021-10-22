# frozen_string_literal: true

require_relative "../rails_helper"

RSpec.describe "Rails integration", type: :request do
  describe "opt_in feature" do
    before do
      get "/api/test_opt_in", headers: headers
    end

    context "without X-FeatureCapabilities header" do
      let(:headers) { {} }

      it "does not use feature" do
        expect(response).to have_attributes(body: { use_opt_in_feature: false }.to_json)
      end
    end

    context "with X-FeatureCapabilities header set to opt-in" do
      let(:headers) { { "X-FeatureCapabilities" => "feature_opt_in" } }

      it "does use feature" do
        expect(response).to have_attributes(body: { use_opt_in_feature: true }.to_json)
      end
    end

    context "with X-FeatureCapabilities header set to opt-out" do
      let(:headers) { { "X-FeatureCapabilities" => "!feature_opt_in" } }

      it "does not use feature" do
        expect(response).to have_attributes(body: { use_opt_in_feature: false }.to_json)
      end
    end
  end

  describe "opt_out feature" do
    before do
      get "/api/test_opt_out", headers: headers
    end

    context "without X-FeatureCapabilities header" do
      let(:headers) { {} }

      it "does use feature" do
        expect(response).to have_attributes(body: { use_opt_out_feature: true }.to_json)
      end
    end

    context "with X-FeatureCapabilities header set to opt-in" do
      let(:headers) { { "X-FeatureCapabilities" => "feature_opt_out" } }

      it "does use feature" do
        expect(response).to have_attributes(body: { use_opt_out_feature: true }.to_json)
      end
    end

    context "with X-FeatureCapabilities header set to opt-out" do
      let(:headers) { { "X-FeatureCapabilities" => "!feature_opt_out" } }

      it "does not use feature" do
        expect(response).to have_attributes(body: { use_opt_out_feature: false }.to_json)
      end
    end
  end

  describe "Feature in model" do
    before do
      get "/api/test_model", headers: headers
    end

    context "without X-FeatureCapabilities header" do
      let(:headers) { {} }

      it "does not use feature" do
        expect(response).to have_attributes(body: { use_model_feature: false }.to_json)
      end
    end

    context "with X-FeatureCapabilities header set to opt-in" do
      let(:headers) { { "X-FeatureCapabilities" => "feature_model" } }

      it "does use feature" do
        expect(response).to have_attributes(body: { use_model_feature: true }.to_json)
      end
    end

    context "with X-FeatureCapabilities header set to opt-out" do
      let(:headers) { { "X-FeatureCapabilities" => "!feature_model" } }

      it "does not use feature" do
        expect(response).to have_attributes(body: { use_model_feature: false }.to_json)
      end
    end
  end
end
