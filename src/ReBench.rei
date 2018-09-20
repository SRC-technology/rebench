/** Benchmark bindings for Reason.

  This package includes a very light, idiomatic API on top of the well-known
  benchmarking library for node.js

  */;

/**
  The benchmark suite type.

  Since this is the type used in the boundaries with the JS library, it is kept
  abstract.
*/
type t;

/**
  The benchmark case type.

  A benchmark case consists of a description and a function that will be
  benchmarked.
  */
type case = {
  /** The description of the test case, such as "Array.map" */
  desc: string,
  /** The actual function to benchmark */
  bench: unit => unit,
};

/**
  The events available to add handlers to.
  */
type event_name =
  | /** Triggered when the suite will begin to evaluate the cases.          */
    Start
  | /** Triggered every time a benchmark case finishes.                     */
    Cycle
  | /** Triggered when the suite finishes evaluating the cases.             */
    Complete;

/**
  The target of a given benchmarking event.
  */
type target = {
  name: string,
  count: int,
};

/**
  A benchmark event.
  */
type event = {
  timestamp: int,
  target,
};

/**
  An event handler function used to respond to benchmark events.
  */
type handler = event => unit;

/**
  Options to run an event suite.
  */
type run_opts = {
  /** Whether this benchmark suite should run synchronously or not */
  async: bool,
};

/**
  Create a new benchmark suite.
  */
let make: unit => t;

/**
  Attach a handler to a particular event name on a test suite.
  */
let on: (event_name, handler, t) => t;

/**
  Add a benchmarking case to a suite.
  */
let add: (case, t) => t;

/**
  Run a benchmark suite!
  */
let run: (run_opts, t) => unit;

/**
  Utility module.
  */
module Utils: {
  /**
    Default announcer that can be used when the test suite finishes to print
    statistics.
    */
  let default_announcer: (~size: int, ~name: string, event) => unit;

  /**
    Default event printer.
    */
  let default_printer: event => unit;
};
