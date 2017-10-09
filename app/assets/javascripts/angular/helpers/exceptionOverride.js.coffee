angular.module('helpers')
  .factory('$exceptionHandler', () ->
    debugger
    
    (exception, cause) ->
      debugger
      exception.message += 'Angular Exception: "' + cause + '"'
      throw exception
  )
