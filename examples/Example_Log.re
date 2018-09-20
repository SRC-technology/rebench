let mySuite = ReBench.make();

let jsLog = ReBench.{desc: "Js.log", bench: () => Js.log("")};
let printString =
  ReBench.{desc: "print_string", bench: () => print_string("")};
let prerrString =
  ReBench.{desc: "prerr_string", bench: () => prerr_string("")};

ReBench.(
  mySuite
  |> add(jsLog)
  |> add(printString)
  |> add(prerrString)
  |> on(Start, Utils.default_announcer(~size=1, ~name="Log functions"))
  |> on(Cycle, Utils.default_printer)
  |> run({async: false})
);
