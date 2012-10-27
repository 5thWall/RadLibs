# Place all the behaviors and hooks related to the matching controller here.
# All this logic will automatically be available in application.js.
# You can use CoffeeScript in this file: http://jashkenas.github.com/coffee-script/

$ ->
  if $('form#new_story').length > 0
    setup_new()

setup_new = (form) ->
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

    $("input#story_words").val JSON.stringify(vals)

  $("input[type='submit']").click ->
    populate_field()

  $("span[contenteditable='true']").each ->
    $(@).focus ->
      orig_txt = $(@).text()
      $(@).data 'orig', $(@).text()

    $(@).blur ->
      if /^\s*$/.exec($(@).text())?
        orig_text = $(@).data('orig') || $(@).data('key')
        $(@).text orig_text

  $("span[data-type='single']").each ->
    $(@).blur ->
      key = $(@).data 'key'
      text = $(@).text()

      if /^\s*$/.exec(text)? then return

      $("span[data-key='#{key}']").each ->
        $(@).text(text)


