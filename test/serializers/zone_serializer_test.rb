require 'test_helper'

class ZoneTest < ActiveSupport::TestCase
  setup do
    @zone = zones(:two)
    @serialized_zone_json = JSON.parse(ZoneSerializer.new(@zone).serialized_json)
  end

  test 'correctly serialize the record' do
    assert @serialized_zone_json.key?('data')
    data = @serialized_zone_json['data']
    assert_equal data['id'], @zone.slug
    assert_equal data['type'], 'zone'
    assert data.key?('attributes')
    attributes = data['attributes']
    assert_equal attributes['name'], @zone.name
    assert_equal attributes['bounds'], [[47.65, 23.669], [47.674, 23.725]]
  end
end
