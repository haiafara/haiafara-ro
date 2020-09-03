# Geographical Operations

## Zone Bounding Box

```ruby
zone = Zone.first
factory = RGeo::Geographic.spherical_factory(srid: 4326)
bounding_box = f.parse_wkt('POLYGON ((23.669 47.65, 23.725 47.65, 23.725 47.674, 23.669 47.674, 23.669 47.65))')
zone.bounding_box = bounding_box
zone.save
```

## Shape from GPX file

```ruby
gpx = GPX::GPXFile.new(gpx_file: 'support/baia-sprie-lacul-albastru.gpx')
gpx_points = gpx.tracks[0].points

f = RGeo::Geographic.spherical_factory(srid: 4326)
shape = f.line_string(
  gpx_points.map do |p|
    f.point(p.lon, p.lat)
  end
)
```

## WKB in hex format

The same as activerecord-postgis-adapter generates.

```ruby
f = RGeo::Geographic.spherical_factory(srid: 4326)
ls = f.parse_wkt('LINESTRING (23.70084 47.662523, 23.700827 47.662598, 23.700791 47.662778)')
RGeo::WKRep::WKBGenerator.new(type_format: :ewkb, emit_ewkb_srid: true, hex_format: true).generate(ls)
```
