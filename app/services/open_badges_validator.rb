class OpenBadgesValidator
    # Required fields for an Assertion per Open Badges 2.0 spec.
    REQUIRED_ASSERTION_FIELDS = %w[
      id
      type
      recipient
      badge
      issuedOn
      verification
    ].freeze
  
    def self.validate(badge_json)
      errors = []
  
      # Ensure @context exists and includes the Open Badges 2.0 URL.
      unless badge_json["@context"]&.include?("https://w3id.org/openbadges/v2")
        errors << "Missing or invalid @context for Open Badges 2.0."
      end
  
      # Ensure the badge type is "Assertion"
      badge_type = badge_json["type"]
      if badge_type.is_a?(Array)
        errors << "Badge 'type' must include 'Assertion'." unless badge_type.include?("Assertion")
      elsif badge_type != "Assertion"
        errors << "Badge 'type' must be 'Assertion'."
      end
  
      # Check all required fields are present.
      REQUIRED_ASSERTION_FIELDS.each do |field|
        errors << "Missing required field: #{field}" unless badge_json[field].present?
      end
  
      # Validate the recipient object.
      if badge_json["recipient"]
        recipient = badge_json["recipient"]
        errors << "Recipient missing 'identity'" unless recipient["identity"].present?
        errors << "Recipient missing 'type'" unless recipient["type"].present?
      end
  
      { valid: errors.empty?, errors: errors }
    end
  end
  