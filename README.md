# :timer_clock: ReBench
> A benchmarking package for ReasonML

*Status*: Usable ALPHA. The default announcer and cycle printers are not the
most beautiful but they get the job done for now. Ideally in the future a
default on-complete handler will inspect the data and show the clear winner. But
this was the minimum I needed to start benchmarking some code.

## Usage

Begin by adding the package to your dev dependencies:

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

Now you're good! Make sure to run `bsb -make-world` :)

## Writting Benchmarks

You begin by creating a `ReBench` suite with `ReBench.make()`. To that suite you
can add as many test cases as you feel like with `add(name, test_case, suite)`.
This makes it possible to chain your calls and provides a very fluent API for
writting the benchmarks.

```reason
let run = size =>
  ReBench.(
    make()
    |> add("ReStruct.BatchedQueue.tail", tail_batched_queue(size))
    |> add("ReStruct.BankersQueue.tail", tail_bankers_queue(size))
    |> add("ReStruct.Lazy.RealTimeQueue.tail", tail_realtime_queue(size))
    |> on(Start, Utils.default_announcer(~size, ~name="Queue.Tail"))
    |> on(Cycle, Utils.default_printer)
    |> on(Complete, _e => Js.log("Done!"))
    |> run(run_opts(~async=false))
  );
```

Running this benchmark has the following output:

```sh
ostera/restruct λ make bench
Benchmark: Queue.Tail (size: 10)
 => ReStruct.BatchedQueue.tail - 365964 ops
 => ReStruct.BankersQueue.tail - 5512905 ops
 => ReStruct.Lazy.RealTimeQueue.tail - 3797100 ops

Benchmark: Queue.Tail (size: 1000)
 => ReStruct.BatchedQueue.tail - 3167 ops
 => ReStruct.BankersQueue.tail - 5572714 ops
 => ReStruct.Lazy.RealTimeQueue.tail - 3344608 ops

Benchmark: Queue.Tail (size: 100000)
 => ReStruct.BatchedQueue.tail - 12 ops
 => ReStruct.BankersQueue.tail - 5365455 ops
 => ReStruct.Lazy.RealTimeQueue.tail - 3057600 ops

Done!
```
