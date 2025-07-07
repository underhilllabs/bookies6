# CLAUDE.md

This file provides guidance to Claude Code (claude.ai/code) when working with code in this repository.

## Project Overview

Bookies is a Rails 7.0 bookmark management application that allows users to save, organize, and archive web bookmarks. The app supports user authentication, tagging, privacy controls, and automatic content archiving.

## Development Commands

### Setup
```bash
bundle install
EDITOR=vim rails credentials:edit -e development  # Add DEV_DB, DEV_DB_USER, DEV_DB_PASSWORD
rails db:schema:load
```

### Running the Application
```bash
rails server                    # Start the Rails server
bundle exec sidekiq            # Start background job processor (for archiving)
```

### Testing
```bash
bundle exec rspec              # Run all tests
bundle exec rspec spec/models/bookmark_spec.rb  # Run specific test file
```

### Database Operations
```bash
rails db:migrate               # Run migrations
rails db:schema:load          # Load schema (preferred for new setup)
rails db:seed                 # Load seed data
```

### Asset Management
```bash
yarn install                   # Install JavaScript dependencies
rails assets:precompile        # Compile assets for production
```

## Architecture

### Core Models
- **Bookmark**: Central model with URL, title, description, privacy settings, and archiving capability
- **User**: Devise-powered authentication with API token support
- **Tag**: Acts-as-taggable-on integration for bookmark categorization

### Key Features
- **Privacy Control**: Bookmarks can be private or public
- **Content Archiving**: Automatic HTML content extraction and storage using Readability gem
- **Tagging System**: Full tagging support with tag clouds and filtering
- **API Support**: JSON API for bookmark creation via external tools
- **Authorization**: Pundit-based policies for access control

### Background Jobs
- **BookmarkArchiveJob**: Processes bookmark archiving asynchronously
- **BookmarkArchiver**: Service class that downloads and processes web content

### Database Schema
- PostgreSQL in production/development
- SQLite3 for testing
- Uses acts-as-taggable-on for tagging infrastructure

### Frontend Stack
- Rails 7.0 with Webpacker
- Bootstrap 4.3.1 for styling
- Stimulus for JavaScript controllers
- HAML for view templates
- SCSS for stylesheets

### Authentication & Authorization
- Devise for user authentication (registration disabled)
- Pundit for authorization policies
- API token support for external integrations

### Key Routes
- `/bookmarks` - Main bookmark listing
- `/bookmarks/search` - Search functionality
- `/api/posts/add.json` - API endpoint for adding bookmarks
- `/tags` - Tag management
- `/users` - User profiles

## Testing Strategy

Tests are organized with:
- Model specs in `spec/models/`
- Policy specs in `spec/policies/`
- Feature specs in `spec/features/`
- Uses RSpec with Capybara for integration testing

## Background Processing

The application uses Sidekiq for background job processing, primarily for:
- Archiving bookmark content
- Processing web page content extraction

Configure Sidekiq in `config/initializers/sidekiq.rb` and ensure Redis is running for job queue management.