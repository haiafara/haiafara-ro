# frozen_string_literal: true

require 'underpass/ql/ql'

# The Underpass library
# Offers various helpers to work with the Overpass API and RGeo objects
module Underpass
end

# Example usage
#
# require 'underpass'
# f = RGeo::Geographic.spherical_factory
# bbox = f.parse_wkt('POLYGON ((23.669 47.65, 23.725 47.65, 23.725 47.674, 23.669 47.674, 23.669 47.65))')
# op_query = 'way["heritage:operator"="lmi"]["ref:ro:lmi"="MM-II-m-B-04508"];'
# Underpass::QL::Query.perform(bbox, op_query)
