type t;

type case = {
  desc: string,
  test: unit => unit,
};

type event_name =
  | Start
  | Cycle
  | Complete;

let event_to_string =
  fun
  | Start => "start"
  | Cycle => "cycle"
  | Complete => "complete";

type target = {
  name: string,
  count: int,
};

type event = {
  timestamp: int,
  target,
};

type handler = event => unit;

type run_opts = {async: bool};

module FFI = {
  [@bs.deriving abstract]
  type __target = {
    name: string,
    count: int,
  };

  [@bs.deriving abstract]
  type __event = {
    timeStamp: int,
    target: __target,
  };

  [@bs.deriving abstract]
  type __run_opts = {async: bool};

  [@bs.module "benchmark"] [@bs.new]
  external __unsafe_make: unit => t = "Suite";

  [@bs.send] external __unsafe_add: (t, string, unit => unit) => t = "add";

  [@bs.send] external __unsafe_on: (t, string, __event => unit) => t = "on";

  [@bs.send] external __unsafe_run: (t, __run_opts) => unit = "run";

  let to_event = e => {
    timestamp: timeStampGet(e),
    target: {
      name: targetGet(e) |> nameGet,
      count: targetGet(e) |> countGet,
    },
  };

  let to_run_opts = ro => __run_opts(~async=ro.async);
};

let make = FFI.__unsafe_make;

let on = (n, h, s) =>
  FFI.__unsafe_on(s, event_to_string(n), e => FFI.to_event(e) |> h);

let add = (c, s) => FFI.__unsafe_add(s, c.desc, c.test);

let run = (o, s) => FFI.(to_run_opts(o) |> __unsafe_run(s));

module Utils = {
  let default_announcer = (~size, ~name, _e) =>
    Js.log({j|Benchmark: $name (size: $size)|j});

  let default_printer = e => {
    let name = e.target.name;
    let count = e.target.count;
    Js.log({j| => $name - $count ops|j});
  };
};
