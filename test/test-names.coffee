assert = require 'assert'
{RSModel} = require '../index'

describe "RSModel", () ->


  describe "@get_singular", () ->

    it "converts camel to snake", () ->
      class RSFooBar extends RSModel
      assert.equal RSFooBar.get_singular(), 'r_s_foo_bar'

    it "can be overridden", () ->
      class Foo extends RSModel
        @singular = 'bob'
      assert.equal Foo.get_singular(), 'bob'

    it "caches the name via @singular", () ->
      class FooBar extends RSModel
      assert.equal FooBar.get_singular(), 'foo_bar'
      FooBar.singular = 'asdf'
      assert.equal FooBar.get_singular(), 'asdf'


  describe "@get_plural", () ->

    it "uses @get_singular() + 's'", () ->
      class Foo extends RSModel
        @get_singular = () -> "asdf"
      assert.equal Foo.get_plural(), 'asdfs'

    it "can be overridden", () ->
      class Foo extends RSModel
        @plural = '1234'
      assert.equal Foo.get_plural(), '1234'

    it "caches the name via @plural", () ->
      class FooBar extends RSModel
      assert.equal FooBar.get_plural(), 'foo_bars'
      FooBar.plural = 'asdf'
      assert.equal FooBar.get_plural(), 'asdf'


  describe "get_singular", () ->
    it "returns @constructor.get_singular()", () ->
      class Foo extends RSModel
        @get_singular: () -> 'x'
      foo = new Foo
      assert.equal foo.get_singular(), 'x'


  describe "get_plural", () ->
    it "returns @constructor.get_plural()", () ->
      class Foo extends RSModel
        @get_plural: () -> 'y'
      foo = new Foo
      assert.equal foo.get_plural(), 'y'
