# Place all the behaviors and hooks related to the matching controller here.
# All this logic will automatically be available in application.js.
# You can use CoffeeScript in this file: http://jashkenas.github.com/coffee-script/

$ ->
  if $('#tagline').length > 0
    setup_tagline()

setup_tagline = ->
  $("span[contenteditable='true']").each ->
    $(@).focus ->
      orig_txt = $(@).text()
      $(@).data 'orig', $(@).text()

    $(@).blur ->
      if /^\s*$/.exec($(@).text())?
        orig_text = $(@).data('orig') || $(@).data('key')
        $(@).text orig_text

      text = $('#tagline').text()

      replace_title text
      replace_tweet text

replace_title = (text) ->
  $('title').text text

replace_tweet = (text) ->
  if $('#tweet-tagline').length > 0
    $('#tweet-tagline iframe').remove()

    tweetBtn = $('<a></a>')
      .addClass('twitter-share-button')
      .attr('href', 'http://twitter.com/share')
      .attr('rel', 'canonical')
      .attr('data-text', text)
    $('#tweet-tagline').append tweetBtn

    twttr.widgets.load()
