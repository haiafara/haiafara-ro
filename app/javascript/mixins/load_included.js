// requires this.included to be set usually from json.included
// requires this.relationsps to be set usually from json.data.attributes.relationships

import { eventBus } from 'packs/haiafara'

export const load_included = {
  methods: {
    filterIncluded(relationships) {
      var relationship_ids = relationships.data.map(obj => obj.id)
      return this.included.filter(obj => {
        // todo: add type checking here
        return relationship_ids.includes(obj.id)
      })
    },
    loadIncludedPOIs() {
      var pois = this.filterIncluded(this.relationships.pois)
      pois.forEach(poi => {
        this.pois.push(poi)
        eventBus.$emit('mapQueueGeoJSON', {
          type: poi.type,
          id: poi.id,
          name: poi.attributes.name,
          geometry: poi.attributes.shape
        })
      })
    },
    loadIncludedTracks() {
      var tracks = this.filterIncluded(this.relationships.tracks)
      tracks.forEach(track => {
        this.tracks.push(track)
      })
    },
    loadIncludedPhotos() {
      var photos = this.filterIncluded(this.relationships.photos)
      photos.forEach(photo => {
        var attributes = photo.attributes
        this.photos.push({
          thumb: attributes.thumbnail,
          src: attributes.large,
          name: attributes.name,
          description_html: attributes.description_html
        })
      })
    }
  }
}
