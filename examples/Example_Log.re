let mySuite = ReBench.make();

let jsLog = ReBench.{desc: "Js.log", bench: () => Js.log("")};
let printString =
  ReBench.{desc: "print_string", bench: () => print_string("")};
let prerrString =
  ReBench.{desc: "prerr_string", bench: () => prerr_string("")};

mySuite
|> ReBench.add(jsLog)
|> ReBench.add(printString)
|> ReBench.add(prerrString)
|> ReBench.on(
     Start,
     ReBench.Utils.default_announcer(~size=1, ~name="Log functions"),
   )
|> ReBench.on(Cycle, ReBench.Utils.default_printer)
|> ReBench.run({async: false});
