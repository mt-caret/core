open! Import
open Import_time

module Unix = Core_unix

module Command = Core_kernel.Command

include (Command
         : (module type of struct include Command end
             with module Deprecated := Command.Deprecated))

module For_unix = Private.For_unix (struct
    module Signal = Signal
    module Sys = Core_sys
    module Thread = Core_thread
    module Time = Time
    module Unix = Unix
  end)

let run = For_unix.run
let shape = For_unix.shape

module Deprecated = struct
  include Command.Deprecated
  let run = For_unix.deprecated_run
end
