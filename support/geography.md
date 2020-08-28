```ruby
zone = Zone.first
factory = RGeo::Geographic.spherical_factory(srid: 4326)
bounding_box = f.parse_wkt('POLYGON ((23.669 47.65, 23.725 47.65, 23.725 47.674, 23.669 47.674, 23.669 47.65))')
zone.bounding_box = bounding_box
zone.save
```
