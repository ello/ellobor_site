root = exports ? this
root.ElloBORShared =
  init: () ->
    ElloBORShared.checkMobile()
    ElloBORShared.masterResizeListener()
    ElloBORShared.backToTop()
    ElloBORShared.paginationForever()
    ElloBORShared.developmentModeStuff()
    ElloBORShared.anchorSwing()

  initAjax: () ->
    ElloBORShared.paginationForever()
    ElloBORShared.developmentModeStuff()

  developmentModeStuff: ->
    if $('body.development_mode').length
      console.log 'Development mode JS is happening.'
    
  checkMobile: ->
    if /Android|webOS|iPhone|iPad|iPod|BlackBerry/i.test(navigator.userAgent)
      if ($(window).width() < 641) ## do stuff for phones
        $('html').addClass('mobile')
        ElloBORShared.updateOrientation()
      else
        $('html').addClass('tablet')
        ElloBORShared.updateOrientation()
    else
      $('html').addClass('desktop')

  setOrientation: ->
    orientation = window.orientation.toString()
    orientations = {
      "0": "portrait",
      "-90": "landscape",
      "90": "landscape",
      "180": "portrait"
    }
    $("body").removeClass('portrait landscape').addClass orientations[orientation]
    console.log "orientation is #{orientations[orientation]}!"

  updateOrientation: ->
    ElloBORShared.setOrientation()

    ## orientation change functions here

  masterResizeListener: ->
    if $('html.mobile, html.tablet').length > 0
      $(window).on "orientationchange", -> ElloBORShared.updateOrientation()

    unless $('html.mobile').length or $('html.tablet').length
      $(window).smartresize ->
        console.log 'resize!'

  backToTop: ->
    $('a').click (e) ->
      if $(this).attr('href') == '#top'
        e.preventDefault()

        $("html, body").stop().animate
          scrollTop: (0)
        , 600, "swing"

  paginationForever: ->
    setTimeout( ->
      if $('#pagination .pagination').length
        if $('#pagination .pagination .next a').length
          $('.load_more').fadeIn('fast')
        else
          $('.load_more').fadeOut('fast')
      else
        $('.load_more').fadeOut('fast')

      if $('#pagination .pagination').length
        $('.load_more a').click (e) ->
          # show loading state
          $('body').addClass('loading').css('cursor','none')
          $('#loading_cursor').show()
          
          e.preventDefault()

          $("#pagination .pagination .next a").click()

        $(document).on "click", "#pagination .pagination a", ->
          $.get @href, null, null, "script"
          false
    , 250)

  anchorSwing: ->
    $('a.anchor_follow').click (e) ->
      e.preventDefault()

      $anchor = $(this)
      top_offset = 155
      $("html, body").stop().animate
        scrollTop: ($($anchor.attr("href")).offset().top - top_offset)
      , 1200, "swing"
  
$(document).ready ->
  ElloBORShared.init()
