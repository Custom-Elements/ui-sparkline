#ui-sparkline
Inline self scaling sparkline, just feed it an array of numbers.

    _ = require 'lodash'

    Polymer 'ui-sparkline',

##Events

##Attributes and Change Handlers
###data
This is a simple array of numbers.

      dataChanged: ->
        if typeof @data is 'string'
          @data = @data.split(' ')
        length = @data.length
        min = _.min @data
        max = _.max @data
        range = max - min
        plot = []
        path = []

Remember that SVG has an inverted Y axis compared to how you would
do math graphs.

        _.each @data, (n, i) ->
          console.log n, i
          x = i
          y = 1 - ((n - min) / range)
          plot.push "#{x},#{y}"
          if i is 0
            path.push "M #{x} #{y}"
          else
            path.push "L #{x} #{y}"

        @plot = plot.join(' ')
        @path = path.join(' ')
        @path = "M 0 0 L 1 1 Z"
        @viewBox = "0 0 #{length} 1"
        @$.spark.classList.add 'show'

##Methods

##Event Handlers

##Polymer Lifecycle

      created: ->

      ready: ->

      attached: ->

      domReady: ->

      detached: ->
