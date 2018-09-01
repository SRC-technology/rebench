let default_announcer = (~size, ~name, _e) =>
  Js.log({j|Benchmark: $name (size: $size)|j});

let default_printer = e => {
  let t = Reckon.targetGet(e);
  let name = Reckon.nameGet(t);
  let count = Reckon.countGet(t);
  Js.log({j| => $name - $count ops|j});
};
