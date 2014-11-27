#ui-sparkline
Inline self scaling sparkline, just feed it an array of numbers.

    _ = require 'lodash'
    graphic = require './ui-sparkline.svg'
    handlebars = require 'handlebars'
    graphic = handlebars.compile(graphic)

    Polymer 'ui-sparkline',

##Events

##Attributes and Change Handlers
###data
This is a simple array of numbers.

      dataChanged: ->
        if typeof @data is 'string'
          @data = _.map @data.split(' '), (n) -> Number(n)
        length = @data.length
        min = _.min @data
        max = _.max @data
        range = max - min
        plot = []
        path = []

Remember that SVG has an inverted Y axis compared to how you would
do math graphs.

        _.each @data, (n, i, all) ->
          x = i / all.length
          y = (n - min) / range
          plot.push "#{x},#{y}"
          if i is 0
            path.push "M #{x},#{y}"
          else
            path.push "L #{x},#{y}"

        @shadowRoot.querySelector('display')?.remove()
        display = document.createElement 'display'
        display.innerHTML = graphic
          plot: plot.join(' ')
          path: path.join(' ')
          points: @data.length
        @shadowRoot.appendChild display

##Methods

##Event Handlers

##Polymer Lifecycle

      created: ->

      ready: ->

So, cheerio in polymer tools doesn't handle inline svg well at all, it ends
up not being great at the XML part. So, in it goes as text.

      attached: ->

      domReady: ->

      detached: ->
