root = exports ? this
root.ElloBORPages =
  init: () ->
    ElloBORPages.watchShareWidgets()
    ElloBORPages.watchModalClose()
  
  watchShareWidgets: ->
    $('.share nav a').on "click.share", (e) ->
      type = $(this).data('share-type')
      link = $(this).attr('href')

      console.log "share type: #{type}"
      unless type == "email"
        e.preventDefault()

        window_width = 700
        window_height = 450

        switch type
          when "facebook"
            window_width = 480
            window_height = 210
          when "twitter"
            window_width = 520
            window_height = 250
          when "pinterest"
            window_width = 750
            window_height = 320
          when "google"
            window_width = 500
            window_height = 385
          when "tumblr"
            window_width = 450
            window_height = 430
          when "reddit"
            window_width = 540
            window_height = 420
          when "linkedin"
            window_width = 460
            window_height = 550

        offset_left = ((screen.width / 2) - (window_width / 2))
        offset_top = ((screen.height / 2) - (window_height / 2))

        window.open(link, "shareWindow", "width=#{window_width},height=#{window_height},left=#{offset_left},top=#{offset_top},scrollbars=no,toolbar=0,location=0,menubar=0,directories=0");

  watchModalClose: ->
    $('#modal').click (e) ->
      unless $(e.target).is('h3') || $(e.target).hasClass('ello_link')
        e.preventDefault()
        $('#modal').fadeOut(175)
      e.stopPropagation()
  
$(document).ready ->
  if $("body.pages").length
    ElloBORPages.init()
