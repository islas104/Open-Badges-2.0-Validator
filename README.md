# Open Badges 2.0 Validator

This is a Rails-based project that validates Open Badges 2.0 metadata. The application lets users upload a badge image (PNG with baked metadata) or a JSON file, or provide a URL to badge metadata. It then extracts the metadata (if needed), validates it against the Open Badges 2.0 specification, and displays the results.

## Features

- **File Upload & URL Input:**  
  Users can either paste a badge URL or upload a badge file (PNG or JSON).
- **Metadata Extraction:**  
  Extracts baked metadata from PNG images and provides basic support for SVG files.
- **Validation:**  
  Checks that the badge metadata meets Open Badges 2.0 requirements.
- **User Feedback:**  
  Displays flash messages showing the extracted metadata and whether the badge is valid.

## Installation

1. **Clone the Repository:**

   ```bash
   git clone https://github.com/islas104/Open-Badges-2.0-Validator.git
   cd Open-Badges-2.0-Validator
   ```

2. **Install Dependencies:**

```bash
  bundle install
```

3. **Install CSS Bundling with Bootstrap:**

```bash
  rails css:install:bootstrap
```

## Installation

**1.Start the Rails Server:**

```bash
  bin/dev
```

or
**You can start the server using::**

```bash
  rails server
```

**2. Open Your Browser::**
Navigate to http://localhost:3000.

**3. Upload or Provide a URL:**

- To upload, choose a badge image (PNG) or a JSON file.
- To use a URL, paste the badge URL in the form.

**4.View the Results:**

- The application will extract the metadata (if applicable), validate it, and display a flash message indicating whether the badge is valid, along with the metadata details.

## Badges Folder

- The repository includes a badges folder containing two JSON files:

A valid badge JSON file.
An invalid badge JSON file (for testing error cases).

Note: The valid badge JSON example is based on the official Open Badges 2.0 specification. You can find the specification and example JSON at [https://www.imsglobal.org/sites/default/files/Badges/OBv2p0Final/index.html]

## Testing

This project includes RSpec tests for the validation logic. To run the tests, execute:

```bash
  bundle exec rspec
```

All tests should pass without any failures.

## Development Notes

Metadata Extraction:

- For PNG files, the app looks for an iTXt chunk with a keyword that includes "openbadges".
- For SVG files, it searches for a <metadata> tag containing a JSON block.
  Error Handling:
- The controller has been enhanced with robust error handling and logging for easier debugging.
  Focus:
- The main emphasis is on backend logic and validation rather than on a polished user interface.

## Time Spent

- I spent approximately 3–4 hours delivering this solution.

## Contact

- If you have any questions or feedback, please reach out to me via islas104@gmail.com.
