class BadgeValidationsController < ApplicationController
    def new
      # Renders the form for badge URL input or file upload.
    end
  
    def validate
      begin
        # Extract badge JSON from uploaded file or URL.
        badge_json = extract_badge_json
      rescue StandardError => e
        Rails.logger.error "Error extracting badge JSON: #{e.message}"
        flash[:error] = "An error occurred while processing the file: #{e.message}"
        return redirect_to root_path
      end
  
      # Validate the badge JSON.
      result = OpenBadgesValidator.validate(badge_json)
  
      if result[:valid]
        flash[:notice] = "Badge is valid! Metadata: #{badge_json}"
      else
        flash[:error] = "Badge is invalid: #{result[:errors].join(', ')}"
      end
  
      redirect_to root_path
    end
  
    private
  
    # Extract badge JSON from file upload or badge URL.
    def extract_badge_json
      if params[:badge_file].present?
        file = params[:badge_file]
  
        if image_file?(file)
          # Check for PNG or SVG based on content type.
          metadata_json = if file.content_type == "image/png"
                            parse_png_metadata(file.tempfile.path)
                          elsif file.content_type == "image/svg+xml"
                            parse_svg_metadata(file.tempfile.path)
                          else
                            raise "Unsupported image format: #{file.content_type}"
                          end
  
          raise "No Open Badges metadata found in the image." if metadata_json.blank?
  
          JSON.parse(metadata_json) rescue {}
        else
          # Assume the file is raw JSON.
          file_content = file.read
          JSON.parse(file_content) rescue {}
        end
  
      elsif params[:badge_url].present?
        response = HTTParty.get(params[:badge_url])
        JSON.parse(response.body) rescue {}
      else
        raise "No badge URL or file provided."
      end
    end
  
    # Check if the uploaded file is an image (by content type).
    def image_file?(file)
      file.content_type.present? && file.content_type.start_with?("image")
    end
  
    # Extract baked metadata from a PNG image.
    # Looks for an iTXt chunk with a keyword including "openbadges".
    def parse_png_metadata(file_path)
      data = File.binread(file_path)
      png_signature = "\x89PNG\r\n\x1a\n".b
      return nil unless data.start_with?(png_signature)
  
      pos = 8 # Skip PNG signature.
      while pos < data.size
        chunk_len = data[pos, 4].unpack1("N")
        chunk_type = data[pos + 4, 4]
        chunk_data = data[pos + 8, chunk_len]
        pos += 12 + chunk_len  # 4 (length) + 4 (type) + chunk_len + 4 (CRC)
  
        if chunk_type == "iTXt"
          parts = chunk_data.split("\x00")
          keyword = parts[0]   # e.g., "openbadges"
          text    = parts.last # actual text payload
          return text if keyword.downcase.include?("openbadges")
        end
      end
      nil
    end
  
    # Basic extraction of metadata from an SVG file.
    # This example looks for a <metadata> tag that contains a JSON block.
    def parse_svg_metadata(file_path)
      content = File.read(file_path)
      # Extract content between <metadata> and </metadata>
      if content =~ /<metadata[^>]*>(.*?)<\/metadata>/m
        metadata = $1.strip
        # Look for a JSON block within the metadata.
        if metadata =~ /(\{.*\})/m
          return $1
        end
      end
      nil
    end
  end
  