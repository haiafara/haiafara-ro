namespace :synchronize do
  desc 'Syncronize Points Of Interest'
  task pois: :environment do
    query = %{
      [out:json][timeout:25][bbox:47.65,23.669,47.674,23.725];
      (
        node["amenity"="place_of_worship"]["religion"="christian"];
        way["amenity"="place_of_worship"]["religion"="christian"];
        relation["amenity"="place_of_worship"]["religion"="christian"];
      );
      out body;
      >;
      out skel qt;
    }
    url = 'https://overpass-api.de/api/interpreter'
    uri = URI(url)
    response = Net::HTTP.post_form(uri, { data: query })
    parsed_json = JSON.parse(response.body, symbolize_names: true)
    elements = parsed_json[:elements]
    ways = elements.select { |e| e[:type] == 'way' }
    nodes = elements.select { |e| e[:type] == 'node' }
    nodes = nodes.map { |e| [e[:id], e] }.to_h
    pois = []
    puts ways.inspect
    f = RGeo::Geographic.spherical_factory(srid: 4326)
    ways.each do |way|
      pois << {
        name: way[:tags][:name],
        shape: f.polygon(
          f.line_string(
            way[:nodes].map do |n|
              f.point(nodes[n][:lon], nodes[n][:lat])
            end
          )
        )
      }
    end
    puts pois.inspect
  end
end

# relation["name"="Árok"]({{bbox}});
