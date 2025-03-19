require 'rails_helper'

RSpec.describe OpenBadgesValidator, type: :service do
  let(:valid_badge_json) do
    {
      "@context" => "https://w3id.org/openbadges/v2",
      "id" => "https://example.org/assertions/123",
      "type" => "Assertion",
      "recipient" => {
        "type" => "email",
        "identity" => "alice@example.org"
      },
      "issuedOn" => "2025-01-01T12:00:00+00:00",
      "verification" => { "type" => "hosted" },
      "badge" => {
        "type" => "BadgeClass",
        "id" => "https://example.org/badges/5",
        "name" => "3-D Printmaster",
        "description" => "Awarded for passing the test.",
        "image" => "https://example.org/badges/5/image",
        "criteria" => { "narrative" => "Test details..." },
        "issuer" => {
          "id" => "https://example.org/issuer",
          "type" => "Profile",
          "name" => "Example Maker Society",
          "url" => "https://example.org",
          "email" => "contact@example.org",
          "verification" => { "allowedOrigins" => "example.org" }
        }
      }
    }
  end

  let(:invalid_badge_json) do
    { "@context" => "https://w3id.org/openbadges/v2", "type" => "Assertion" }
  end

  let(:missing_context_json) do
    valid_badge_json.except("@context")
  end

  let(:malformed_json) { "this is not json" }

  it "validates a correct badge JSON" do
    result = described_class.validate(valid_badge_json)
    expect(result[:valid]).to eq(true)
    expect(result[:errors]).to be_empty
  end

  it "rejects an incomplete badge JSON" do
    result = described_class.validate(invalid_badge_json)
    expect(result[:valid]).to eq(false)
    expect(result[:errors]).not_to be_empty
  end

  it "rejects a badge JSON with missing @context" do
    result = described_class.validate(missing_context_json)
    expect(result[:valid]).to eq(false)
    expect(result[:errors]).to include("Missing or invalid @context for Open Badges 2.0.")
  end

  it "raises an error when given malformed JSON" do
    expect {
      JSON.parse(malformed_json)
    }.to raise_error(JSON::ParserError)
  end
end
