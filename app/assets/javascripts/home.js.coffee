# Place all the behaviors and hooks related to the matching controller here.
# All this logic will automatically be available in application.js.
# You can use CoffeeScript in this file: http://jashkenas.github.com/coffee-script/

$ ->
  if $ '#tagline'
    setup_tagline()

setup_tagline = ->
  $("span[contenteditable='true']").each ->
    $(@).focus ->
      orig_txt = $(@).text()
      console.log $(@)
      console.log $(@).text()
      $(@).data 'orig', $(@).text()

    $(@).blur ->
      if /^\s*$/.exec($(@).text())?
        orig_text = $(@).data('orig') || $(@).data('key')
        $(@).text orig_text

      replace_title $('#tagline').text()

replace_title = (text) ->
  $('title').text text
