#ui-sparkline
Inline self scaling sparkline, just feed it an array of numbers.

    _ = require 'lodash'

    Polymer 'ui-sparkline',

##Events

##Attributes and Change Handlers
###data
This is a simple array of numbers.

      dataChanged: ->
        min = _.min @data
        max = _.max @data
        range = max - min
        plot = []

Remember that SVG has an inverted Y axis compared to how you would
do math graphs.

        _.each @data, (n, i) =>
          if i < (@data.length - 1)
            plot.push
              n: n
              x1: i / @data.length * 100
              y1: 100 - (n - min) / range * 100
              x2: (i + 1) / @data.length * 100
              y2: 100 - (@data[i+1] - min) / range * 100

        console.log plot
        @$.segments.model =
          plot: plot

##Methods

##Event Handlers

##Polymer Lifecycle

      created: ->

      ready: ->

      attached: ->

      domReady: ->

      detached: ->
