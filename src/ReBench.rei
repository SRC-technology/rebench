/**
  benchmark bindings for Reason.

  This package includes a very light, idiomatic API on top of the well-known
  benchmarking library for node.js

  */;

/**
  The test suite type.

  Since this is the type used in the boundaries with the JS library, it is kept
  abstract.
*/
type t;

type case = {
  desc: string,
  test: unit => unit,
};

type event_name =
  | Start
  | Cycle
  | Complete;

[@bs.deriving abstract]
type target = {
  name: string,
  count: int,
};

[@bs.deriving abstract]
type event = {
  timeStamp: int,
  target,
};

type handler = event => unit;

[@bs.deriving abstract]
type run_opts = {async: bool};

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

module Utils: {
  let default_announcer: (~size: int, ~name: string, event) => unit;

  let default_printer: event => unit;
};
