root = exports ? this
root.ElloBORPages =
  init: () ->
    ElloBORPages.doAThing()

  initAjax: () ->
    ElloBORPages.doAThing()
  
  doAThing: ->
    console.log 'thing!'
  
$(document).ready ->
  if $("body.pages").length
    ElloBORPages.init()
