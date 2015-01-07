#ui-sparkline
Inline self scaling sparkline, just feed it an array of numbers.

    graphic = require './ui-sparkline.svg'
    mustache = require 'mustache'

    render = (parameters) ->
      mustache.render graphic, parameters

    Polymer 'ui-sparkline',

##Events

##Attributes and Change Handlers
###data
This is a simple array of numbers.

      dataChanged: ->
        if typeof @data is 'string'
          @data = @data.split(' ').map (n) -> Number(n)
        length = @data.length
        min = Number.MAX_VALUE
        max = Number.MIN_VALUE
        @data.forEach (n) ->
          if n < min
            min = n
          if n > max
            max = n
        range = max - min
        plot = []
        path = []

Remember that SVG has an inverted Y axis compared to how you would
do math graphs.

        @data.forEach (n, i, all) ->
          x = i / all.length
          y = (n - min) / range
          plot.push "#{x},#{y}"
          if i is 0
            path.push "M #{x},#{y}"
          else
            path.push "L #{x},#{y}"

        @shadowRoot.querySelector('display')?.remove()
        display = document.createElement 'display'
        display.innerHTML = render
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
