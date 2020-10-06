# frozen_string_literal: true

module ZoneLoader
  extend ActiveSupport::Concern

  included do
    before_action :load_zone
  end

  def load_zone
    @zone = Zone.includes(:pois).friendly.find(params[:id])
    @resource_json = ZoneSerializer.new(
      @zone,
      include: %i[photos pois tracks]
    ).serialized_json
  end
end
