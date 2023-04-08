# haiafara.ro

[![Coverage Status](https://coveralls.io/repos/github/haiafara/haiafara-ro/badge.svg?branch=development)](https://coveralls.io/github/haiafara/haiafara-ro?branch=development)
[![View performance data on Skylight](https://badges.skylight.io/status/P2iwuIZhzoOK.svg)](https://oss.skylight.io/app/applications/P2iwuIZhzoOK)
[![Depfu](https://badges.depfu.com/badges/8de533e4fd24653ae0761504fb31f64a/overview.svg)](https://depfu.com/github/haiafara/haiafara-ro?project_id=7587)
[![Gitter chat](https://badges.gitter.im/haiafara/community.png)](https://gitter.im/haiafara/community)
[![Licensed under the Apache License, Version 2.0](https://img.shields.io/badge/License-Apache%202.0-blue.svg)](http://www.apache.org/licenses/LICENSE-2.0)

![haiafara.ro screenshot](support/haiafara-screenshot.png)

"Hai afară!" ("Come outside!" in Romanian) is a Ruby on Rails application used to showcase hiking, biking and running trails as well as other types of tourist attractions in a given zone of interest.

## Setup

### Convert a user to admin

Register a user the usual way and then run:

1. Locally:

        rails users:make_admin[user@email.com]

2. On your deployed instance via Capistrano:

        cap production users:make_admin[user@email.com]

## Uses the following libaries / frameworks

*   [Tailwind CSS](https://tailwindcss.com/)
*   [Leaflet](https://leafletjs.com/)
*   [Leaflet.fullscreen](https://github.com/Leaflet/Leaflet.fullscreen)
*   [Leaflet-active-area](https://github.com/Mappy/Leaflet-active-area)
*   [CSS Element Queries](https://github.com/marcj/css-element-queries)
*   [vue-it-bigger](https://github.com/haiafara/vue-it-bigger)

## License

This project is licensed under the the [Apache License, Version 2.0](http://www.apache.org/licenses/LICENSE-2.0).
