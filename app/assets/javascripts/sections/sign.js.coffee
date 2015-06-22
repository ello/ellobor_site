root = exports ? this
root.ElloBORSign =
  init: () ->
    if $('body.verify').length
      ElloBORSign.killAnimation()
  
  killAnimation: ->
    setTimeout ->
      $('.icon').removeClass('animate')
    , 2100
  
$(document).ready ->
  if $("body.sign").length
    ElloBORSign.init()
