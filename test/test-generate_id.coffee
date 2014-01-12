assert = require 'assert'
{RSModel} = require '../index'

describe "@generate_id", () ->

  it "generates 8-digit decimal strings", () ->
    for i in [0...1000]
      assert.ok RSModel.generate_id().match /^[0-9]{8}$/
