# :timer_clock: Reckon
> A benchmarking package for ReasonML

*Status*: Usable ALPHA. The default announcer and cycle printers are not the
most beautiful but they get the job done for now. Ideally in the future a
default on-complete handler will inspect the data and show the clear winner. But
this was the minimum I needed to start benchmarking some code.

## Usage

Begin by adding the package to your dev dependencies:

```sh
ostera/reactor λ yarn add @ostera/reckon --dev
```

And including it in your `bsconfig.json` file too:

```json
{
  // ...
  "suffix": ".bs.js",
  "bs-dependencies": [
    "reckon",
  ],
  "warnings": {
    "error" : "+101"
  },
  // ... 
}
```

Now you're good! Make sure to run `bsb -make-world` :)

## Writting Benchmarks

You begin by creating a `Reckon` suite with `Reckon.make()`. To that suite you
can add as many test cases as you feel like with `add(name, test_case, suite)`.
This makes it possible to chain your calls and provides a very fluent API for
writting the benchmarks.

```reason
let run = size =>
  Reckon.(
    make()
    |> add("ReStruct.BatchedQueue.tail", tail_batched_queue(size))
    |> add("ReStruct.BankersQueue.tail", tail_bankers_queue(size))
    |> add("ReStruct.Lazy.RealTimeQueue.tail", tail_realtime_queue(size))
    |> on(Start, default_announcer(~size, ~name="Queue.Tail"))
    |> on(Cycle, default_printer)
    |> on(Complete, _e => Js.log("Done!"))
    |> run(run_opts(~async=false))
  );
```
