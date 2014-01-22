**Yet another model framework**

[![Build Status](https://secure.travis-ci.org/ReclaimSoftware/rs-model.png)](http://travis-ci.org/ReclaimSoftware/rs-model)


### RSModel <big><big>&cap;</big></big> Backbone.Model

    get, set
    .id
    constructor, initialize

TODO:

    isValid, validate
    has, clone, toJSON
    keys,values,pairs,invert,pick,omit
    url


### Singular, Plural

    model.get_singular()  # Default: snake_case(class name)
    model.get_plural()    # Default: singular + "s"
    
    class Goose
      @plural = "geese"


### Storage

All key parts are joined by ":".

    [plural, id] -> JSON

TODO:

    [plural, id, association, other_id] -> empty
    [singular + "_revs", id, rev_id]    -> JSON


### Misc

`model.path()` &rarr; `"/#{plural}/#{id}"`


### Model.init

    Model.init(app)           # checks app.dir/models/*, sets the following
    Model.classes             # {'FooBar': FooBar}
    Model.classes_by_plural   # {'foo_bars': FooBar}


### Model.middleware

    Model.middleware()

If all of

- `req.method` is `GET`
- `req.params` contains an `id` matching `/^[a-zA-Z0-9_-]+$/`
- `req.url` starts with `/plural/` for a known model

...then fetch the model.

If the model exists, set `req.singular` to the model.

If not, `res.render '404'` and don't call `next()`.


### [License: MIT](LICENSE.txt)
