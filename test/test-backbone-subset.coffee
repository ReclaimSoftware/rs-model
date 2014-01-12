assert = require 'assert'
{RSModel} = require '../index'
backbone = require 'backbone'

describe "RSModel", () ->
  models = null
  beforeEach () ->
    models = [
      new Foo
      new BackboneFoo
    ]


  describe "get", () ->

    it "returns the attribute", () ->
      for m in models
        m.attributes = {foo: 123}
        assert.strictEqual m.get('foo'), 123

    it "returns null when the attribute is set to null", () ->
      for m in models
        m.attributes = {foo: null}
        assert.strictEqual m.get('foo'), null

    it "returns undefined when an attribute D.N.E.", () ->
      for m in models
        m.attributes = {}
        assert.strictEqual m.get('foo'), undefined


  describe "set", () ->

    it "updates @attributes", () ->
      for m in models
        m.set 'foo', 'bar'
        assert.strictEqual m.attributes['foo'], 'bar'

    it "updates @id also", () ->
      for m in models
        m.set 'id', 'foo'
        assert.strictEqual m.attributes['id'], 'foo'
        assert.strictEqual m.id, 'foo'

    it "can also take a dictionary", () ->
      for m in models
        m.set {x: 'foo', id: 'bar'}
        assert.strictEqual m.attributes['x'], 'foo'
        assert.strictEqual m.attributes['id'], 'bar'
        assert.strictEqual m.id, 'bar'


  describe ".id", () ->

    it "is undefined by default", () ->
      for m in models
        assert.strictEqual m.id, undefined

    it "is set by .set", () ->
      for m in models
        m.set 'id', 'foo'
        assert.strictEqual m.attributes['id'], 'foo'
        assert.strictEqual m.id, 'foo'

    it "is set by the constructor", () ->
      for m in models
        m2 = new m.constructor {id: 'asdf'}
        assert.strictEqual m2.attributes['id'], 'asdf'
        assert.strictEqual m2.id, 'asdf'


  describe "isValid", () ->

    it "is true by default", () ->
      for m in models
        assert.strictEqual m.isValid(), true

    xit "uses .validate if available"

  describe "validate", () ->

    it "is optional", () ->
      class Bar extends Model
      BackboneBar = backbone.Model.extend {}
      new Bar
      new BackboneBar


  describe "initialize", () ->

    it "is optional", () ->
      class Bar extends Model
      BackboneBar = backbone.Model.extend {}
      new Bar
      new BackboneBar

    it "is called by the constructor after attributes are set", () ->
      rs_called = false
      backbone_called = false
      class Bar extends Model
        initialize: () ->
          rs_called = true if @id == 'foo'
      BackboneBar = backbone.Model.extend
        initialize: () ->
          backbone_called = true if @id == 'foo'
      new Bar {id: 'foo'}
      new BackboneBar {id: 'foo'}
      assert.ok rs_called and backbone_called


  describe "has", () ->
    xit()


  describe "toJSON", () ->
    xit "returns a shallow copy of attributes", () ->


  describe "{keys,values,pairs,invert,pick,omit}", () ->
    xit "proxies to underscore"


  describe "url", () ->
    xit()


  describe "clone", () ->
    xit()


class Model extends RSModel
class Foo extends Model
BackboneFoo = backbone.Model.extend({})
