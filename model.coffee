fs = require 'fs'
_ = require 'underscore'
{camel_to_snake} = require 'rs-util'

class RSModel

  @init: (@app) ->
    return if @classes
    @classes = {}
    @classes_by_plural = {}
    models_dir = "#{@app.dir}/models"
    filenames = fs.readdirSync models_dir
    filenames = _.filter filenames, (filename) -> filename.match /^[^.].*\.coffee$/
    for filename in filenames
      module = require("#{models_dir}/#{filename}")
      keys = _.keys module
      throw new Error "expected model module to export exactly one item" if keys.length != 1
      cls = module[keys[0]]
      @classes[cls.name] = cls
      @classes_by_plural[cls.get_plural()] = cls

  @middleware: () ->
    @init() if not @classes_by_plural
    classes_by_plural = @classes_by_plural
    (req, res, next) =>
      {id} = req.params
      return next() if (not id) or (req.method != 'GET') or not id.match(/^[a-zA-Z0-9_-]+$/)
      cls = @_class_for_url req.url, classes_by_plural
      return next() if not cls
      cls.fetch id, (e, model) =>
        if e
          return res.status(404).render '404' if e.notFound
          throw e
        req[cls.get_singular()] = model
        next()

  @_class_for_url: (url, classes_by_plural) ->
    for plural of classes_by_plural
      if url.indexOf(plural) == 1 and url.charAt(0) == '/' and url.charAt(plural.length + 1) == '/'
        return classes_by_plural[plural]
    null

  @fetch: (id, c) ->
    key = "#{@get_plural()}:#{id}"
    @app.db.get key, (e, json) =>
      return c e if e
      c null, new @ JSON.parse json

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

  toJSON: () ->
    copy = {}
    for k, v of @attributes
      copy[k] = v
    copy

  @get_plural: () -> @plural or @get_singular() + 's'
  @get_singular: () -> @singular or camel_to_snake @name
  get_plural: () -> @constructor.get_plural()
  get_singular: () -> @constructor.get_singular()


module.exports = {RSModel}
