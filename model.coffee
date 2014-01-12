class RSModel

  @generate_id: () ->
    Math.random().toFixed(8).substr(2)

  constructor: (attributes = {}) ->
    @attributes = {}
    @set attributes
    @initialize() if @initialize

  isValid: () -> true

  get: (key) -> @attributes[key]

  set: (key, value) ->
    if (typeof key) == 'object'
      for k, v of key
        @set k, v
      return
    @attributes[key] = value
    if key == 'id'
      @id = value


module.exports = {RSModel}
