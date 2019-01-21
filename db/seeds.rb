# This file should contain all the record creation needed to seed the database with its default values.
# The data can then be loaded with the rails db:seed command (or created alongside the database with db:setup).
#
# Examples:
#
#   movies = Movie.create([{ name: 'Star Wars' }, { name: 'Lord of the Rings' }])
#   Character.create(name: 'Luke', movie: movies.first)
f = RGeo::Geographic.spherical_factory(srid: 4326)

region = Region.create(name: 'Maramures')

zone = Zone.create(
  name: 'Baia Sprie',
  bounding_box: RGeo::Cartesian::BoundingBox.create_from_points(
    f.point(23.669, 47.65),
    f.point(23.725, 47.674)
  ).to_geometry,
  region: region,
  default: true
)