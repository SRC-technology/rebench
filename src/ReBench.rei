/**
  Benchmark bindings for Reason.

  This package includes a very light, idiomatic API on top of the well-known
  benchmarking library for node.js

  */;

/**
  The test suite type.

  Since this is the type used in the boundaries with the JS library, it is kept
  abstract.
*/
type t;

/**
  The test case type.

  A test case consists of a description and a function that will execute it.
  */
type case = {
  /** The description of the test case, such as "Array.map" */
  desc: string,
  /** The actual test function */
  test: unit => unit,
};

/**
  The events available to add handlers to.
  */
type event_name =
  | /** Triggered when the the test suite will begin to evaluate the cases. */
    Start
  | /** Triggered every time a test case finishes.                          */
    Cycle
  | /** Triggered when the the test suite finishes evaluating the cases.    */
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
  /** Whether this test suite should run synchronously or not */
  async: bool,
};

/**
  Create a new test suite.
  */
let make: unit => t;

/**
  Attach a handler to a particular event name on a test suite.
  */
let on: (event_name, handler, t) => t;

/**
  Add a test case to a test suite.
  */
let add: (case, t) => t;

/**
  Run a test suite!
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
