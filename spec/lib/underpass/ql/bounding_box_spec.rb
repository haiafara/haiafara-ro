# frozen_string_literal: true

require 'rails_helper'
require 'underpass'

describe Underpass::QL::BoundingBox do
  subject { described_class }
  describe '#from_geometry' do
    it 'returns the correct bounding box string' do
      geometry = RGeo::Geographic.spherical_factory.parse_wkt(
        'POLYGON ((1.0 10.0, 2.0 10.0, 2.0 11.0, 1.0 11.00, 1.0 10.0))'
      )
      expect(subject.from_geometry(geometry)).to eq('bbox:10.0,1.0,11.0,2.0')
    end
  end
end
