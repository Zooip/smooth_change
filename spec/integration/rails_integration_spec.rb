# frozen_string_literal: true

require_relative "../rails_helper"

RSpec.describe "Rails", type: :request do
  describe "opt_in feature" do
    before do
      get "/api/test_opt_in", headers: headers
    end

    context "without X-ApiFeatureFlags header" do
      let(:headers) { {} }

      it "get endpoint" do
        expect(response).to have_attributes(body: { use_opt_in_feature: false }.to_json)
      end
    end

    context "with X-ApiFeatureFlags header set to opt-in" do
      let(:headers) { { "X-ApiFeatureFlags" => "feature_opt_in" } }

      it "get endpoint" do
        expect(response).to have_attributes(body: { use_opt_in_feature: true }.to_json)
      end
    end

    context "with X-ApiFeatureFlags header set to opt-out" do
      let(:headers) { { "X-ApiFeatureFlags" => "!feature_opt_in" } }

      it "get endpoint" do
        expect(response).to have_attributes(body: { use_opt_in_feature: false }.to_json)
      end
    end
  end

  describe "opt_out feature" do
    before do
      get "/api/test_opt_out", headers: headers
    end

    context "without X-ApiFeatureFlags header" do
      let(:headers) { {} }

      it "get endpoint" do
        expect(response).to have_attributes(body: { use_opt_out_feature: true }.to_json)
      end
    end

    context "with X-ApiFeatureFlags header set to opt-in" do
      let(:headers) { { "X-ApiFeatureFlags" => "feature_opt_out" } }

      it "get endpoint" do
        expect(response).to have_attributes(body: { use_opt_out_feature: true }.to_json)
      end
    end

    context "with X-ApiFeatureFlags header set to opt-out" do
      let(:headers) { { "X-ApiFeatureFlags" => "!feature_opt_out" } }

      it "get endpoint" do
        expect(response).to have_attributes(body: { use_opt_out_feature: false }.to_json)
      end
    end
  end

  describe "Feature in model" do
    before do
      get "/api/test_model", headers: headers
    end

    context "without X-ApiFeatureFlags header" do
      let(:headers) { {} }

      it "get endpoint" do
        expect(response).to have_attributes(body: { use_model_feature: false }.to_json)
      end
    end

    context "with X-ApiFeatureFlags header set to opt-in" do
      let(:headers) { { "X-ApiFeatureFlags" => "feature_model" } }

      it "get endpoint" do
        expect(response).to have_attributes(body: { use_model_feature: true }.to_json)
      end
    end

    context "with X-ApiFeatureFlags header set to opt-out" do
      let(:headers) { { "X-ApiFeatureFlags" => "!feature_model" } }

      it "get endpoint" do
        expect(response).to have_attributes(body: { use_model_feature: false }.to_json)
      end
    end
  end
end
