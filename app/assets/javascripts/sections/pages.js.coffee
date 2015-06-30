root = exports ? this
root.ElloBORPages =
  init: () ->
    ElloBORPages.watchShareWidgets()
    ElloBORPages.watchFormDoubleClick()
    ElloBORPages.loadInitialSignatories()
  
  watchShareWidgets: ->
    $('.share nav a').on "click.share", (e) ->
      type = $(this).data('share-type')
      link = $(this).attr('href')

      window.analytics?.track 'share',
        type: type,
        link: link

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
    $('#modal').off "click.modal"
    $('#modal').on "click.modal", (e) ->
      unless $(e.target).is('h3') || $(e.target).hasClass('ello_link')
        e.preventDefault()
        $('#modal').fadeOut(175)
      e.stopPropagation()

  watchFormDoubleClick: ->
    $('.form_holder form').submit (e) ->
      if $(this).hasClass('submitting')
        return false
      else
        $(this).addClass('submitting')
        setTimeout ->
          $('.form_holder form').removeClass('submitting')
        , 1000

  loadInitialSignatories: ->
    $signatories_init_link = $('.signatories .loading')
    
    $signatories_init_link.waypoint (e, direction) ->
      if direction is "down"
        $signatories_init_link.find('a').click()
        $signatories_init_link.waypoint('destroy')
    , {offset: '250%'}
    # setTimeout ->
    #   $('.signatories .loading a').click()
    # , 500

  loadMoreSignatories: (signatories_html, next_link_html) ->
    if $('.loading').length
      $('.loading').remove()

    $signatories_list = $('.signatories ul')
    $next_link = $('.signatories .load_more_link')

    $signatories_list.append(signatories_html).show()
    $next_link.html(next_link_html)

    ElloBORPages.listenForSignatoriesPagination($next_link)

  listenForSignatoriesPagination: ($next_link) ->
    $footer_anchor = $('footer.bottom')
    $footer_anchor.waypoint('destroy')
    $footer_anchor.waypoint (e, direction) ->
      if direction is "down"
        $next_link.find('a').click()
        $footer_anchor.waypoint('destroy')
    , {offset: '113%'}
  
$(document).ready ->
  if $("body.pages").length
    ElloBORPages.init()
