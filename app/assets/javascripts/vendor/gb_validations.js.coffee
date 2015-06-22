# gb Validations, created by Jake McHargue, maintained by gb & jm
GBValidations = window.GBValidations = GBValidations

GBValidations =
  init: () ->
    GBValidations.listenForValidations()

  listenForValidations: ->
    $('form').submit (e) ->
      valid = true # innocent until proven guilty
      if $(this).find('*[data-validates]').length
        $form = $(this)
        $form.removeClass('error').find('button').removeAttr('disabled').removeClass('disabled')
        $fields = $form.find('*[data-validates]')
        $fields.each ->
          $field = $(this)
          $note = $field.next('.note')
          $field.removeClass('error')
          $note.removeClass('error')
          validations = $field.data('validates').split(' ')
          for validation in validations
            unless GBValidations.validateProperty(validation, $field)
              $field.addClass('error')
              $note.addClass('error')
              $form.addClass('error')
              e.preventDefault()
              valid = false
      return false unless valid

  validateProperty: (property, $field) ->
    if property == "presence"
      return false if $field.val() == ''
      return true
    else if property == "url"
      is_url_format = $field.val().match(/(^([a-zA-Z0-9]+(\.[a-zA-Z0-9]+)+.*)$)|(^(http|https):\/\/([a-zA-Z0-9]+(\.[a-zA-Z0-9]+)+.*)$)/)
      is_empty = $field.val() == ''
      return true if is_empty
      return false if !is_url_format
      return true
    else if property == "instagram-url"
      is_instagram_format = $field.val().match(/^(https?:\/\/)?([\da-z\.-]+)?(instagram)\.([a-z\.]{2,6})([\/\w \.#-]*)*\/?$/)
      is_empty = $field.val() == ''
      return true if is_empty
      return false if !is_instagram_format
      return true

    console.log("don't have a validation for " + property)
    return false


window.GBValidations = GBValidations
$(document).ready ->
  GBValidations.init()
