# frozen_string_literal: true

require 'administrate/base_dashboard'

class TrackDashboard < Administrate::BaseDashboard
  # ATTRIBUTE_TYPES
  # a hash that describes the type of each of the model's fields.
  #
  # Each different type represents an Administrate::Field object,
  # which determines how the attribute is displayed
  # on pages throughout the dashboard.
  ATTRIBUTE_TYPES = {
    zones: Field::HasMany,
    id: Field::Number,
    name: Field::String,
    description: Field::Text,
    slug: Field::String,
    shape: Field::String.with_options(searchable: false),
    created_at: Field::DateTime,
    updated_at: Field::DateTime,
    recommended: Field::Boolean
    # photos: Field::HasMany
  }.freeze

  # COLLECTION_ATTRIBUTES
  # an array of attributes that will be displayed on the model's index page.
  #
  # By default, it's limited to four items to reduce clutter on index pages.
  # Feel free to add, remove, or rearrange items.
  COLLECTION_ATTRIBUTES = %i[
    id
    name
  ].freeze

  # SHOW_PAGE_ATTRIBUTES
  # an array of attributes that will be displayed on the model's show page.
  SHOW_PAGE_ATTRIBUTES = %i[
    zones
    id
    name
    description
    slug
    shape
    recommended
    created_at
    updated_at
  ].freeze

  # FORM_ATTRIBUTES
  # an array of attributes that will be displayed
  # on the model's form (`new` and `edit`) pages.
  FORM_ATTRIBUTES = [
    :zones,
    :name,
    :description,
    :recommended
    # :photos
  ].freeze

  # Overwrite this method to customize how pois are displayed
  # across all pages of the admin dashboard.
  #
  def display_resource(track)
    track.name.to_s
  end
end
