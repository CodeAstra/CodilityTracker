@highlightElement = (eleSelector) ->
  $(eleSelector).addClass('highlighted')
  setTimeout((()-> $(eleSelector).removeClass('highlighted')), 1500)
