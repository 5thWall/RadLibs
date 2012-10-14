# Place all the behaviors and hooks related to the matching controller here.
# All this logic will automatically be available in application.js.
# You can use CoffeeScript in this file: http://jashkenas.github.com/coffee-script/

$ ->
  if $ 'form#new_template'
    setup_new()

setup_new = ->
  $("input[type='submit']").click ->
    text = $ 'textarea#template_template'
    str = text.val()
    str = str.replace /\{\{(.*?)\}\}/g, (match, p1) ->
      string = p1.split(' ').join('_')
      "{{#{string}}}"

    text.val str
