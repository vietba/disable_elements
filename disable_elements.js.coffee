$.fn.disabled = ->
  @each ->
    _this = this
    $(this).prop("disabled", true)
    $(this).addClass("disabled")
    # need to move handlers to another event to prevent click a disabled button in IE 9,10 
    events = $._data( this, "events" )
    if events and events['click']
      $.each events["click"], ->
        # this = the function
        $(_this).on "enabled_click", this
      $(this).off "click"
    return this
  return this

$.fn.enabled = ->
  @each ->
    _this = this
    $(this).prop("disabled", false)
    $(this).removeClass("disabled")
    # return the handlers to event "click"
    events = $._data( this, "events" )
    if events and events['enabled_click']
      $.each events["enabled_click"], ->
        # this = the function
        $(_this).on "click", this
      delete $._data(_this, "events").enabled_click
    return this
  return this

$.fn.enabledToggle = (val) ->
  if val
    $(this).enabled()
  else
    $(this).disabled()