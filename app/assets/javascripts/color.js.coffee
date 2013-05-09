$ ->
  $('#palette_id').on 'change', ->
    palette_id = $(this).val()
    uri = 'http://www.colourlovers.com/api/palette/' + palette_id +
          '?format=json&jsonCallback=?'
    $.getJSON uri, (results) ->
      hex_codes = results[0].colors
      index = 1
      for hex_code in hex_codes
        $('#color' + index).css('background-color', '#' + hex_code)
        index++
