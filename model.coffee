{camel_to_snake} = require 'rs-util'

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

  @get_plural: () -> @plural or= @get_singular() + 's'
  @get_singular: () -> @singular or= camel_to_snake @name
  get_plural: () -> @constructor.get_plural()
  get_singular: () -> @constructor.get_singular()


module.exports = {RSModel}
