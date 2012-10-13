# Place all the behaviors and hooks related to the matching controller here.
# All this logic will automatically be available in application.js.
# You can use CoffeeScript in this file: http://jashkenas.github.com/coffee-script/

$ ->
  console.log "ready"

  if $ 'form#new_radlib'
    setup_new()

setup_new = (form) ->
  console.log "setting up bindings"
  populate_field = ->
    vals = {}

    $("span[data-type='array']").each ->
      key = $(@).data 'key'
      val = $(@).text()
      vals[key] ||= []
      vals[key].push val

    $("span[data-type='single']").each ->
      key = $(@).data 'key'
      val = $(@).text()
      vals[key] = val

    $("input#radlib_words").val JSON.stringify(vals)

  $("input[type='submit']").click ->
    populate_field()
