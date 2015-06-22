root = exports ? this
root.ElloBORSign =
  init: () ->
    if $('body.verify').length
      ElloBORSign.killAnimation()
  
  killAnimation: ->
    setTimeout ->
      $('.icon').removeClass('animate')
    , 2100

  submitSuccess: ->
    alert 'we did it!'

  submitError: (form_html) ->
    $('.sign .form_holder').html(form_html)
  
$(document).ready ->
  if $("body.sign").length
    ElloBORSign.init()
