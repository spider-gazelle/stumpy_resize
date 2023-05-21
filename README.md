# stumpy resize

Image resize algorithms in pure crystal

## Installation

1. Add the dependency to your `shard.yml`:

   ```yaml
   dependencies:
     stumpy_resize:
       github: spider-gazelle/stumpy_resize
   ```

2. Run `shards install`

## Usage

```crystal
require "stumpy_resize"

# read
canvas = StumpyPNG.read("./path/image.png")

# resize
resized_canvas = StumpyResize.resize(canvas, 320, 320)

# write
StumpyPNG.write(resized_canvas, "./path/resized.png")
```

## Contributing

1. Fork it (<https://github.com/spider-gazelle/stumpy_resize/fork>)
2. Create your feature branch (`git checkout -b my-new-feature`)
3. Commit your changes (`git commit -am 'Add some feature'`)
4. Push to the branch (`git push origin my-new-feature`)
5. Create a new Pull Request

## Contributors

- [Stephen von Takach](https://github.com/stakach) - creator and maintainer
