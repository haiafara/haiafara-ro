module.exports = {
  future: {
    removeDeprecatedGapUtilities: true,
  },
  purge: {
    enabled: true,
    content: [
      './app/javascript/**/*.vue'
    ],
  }
}
