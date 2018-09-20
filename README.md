# :timer_clock: re:bench
> Benchmarking for ReasonML

*Status*: Usable ALPHA. The default announcer and cycle printers are not the
most beautiful but they get the job done for now. Ideally in the future a
default on-complete handler will inspect the data and show the clear winner. But
this was the minimum I needed to start benchmarking some code.

Homepage: https://stockholmrc.github.io/rebench/ReBench/

## Installation

```sh
ostera/reactor λ yarn add rebench --dev
```

And including it in your `bsconfig.json` file too:

```json
{
  // ...
  "suffix": ".bs.js",
  "bs-dependencies": [
    "rebench",
  ],
  "warnings": {
    "error" : "+101"
  },
  // ... 
}
```

Now you're good! Make sure to run `bsb -make-world` and check the docs! :)
