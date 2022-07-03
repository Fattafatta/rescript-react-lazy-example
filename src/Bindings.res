module Suspense = {
  @module("react") @react.component
  external make: (~fallback: React.element, ~children: React.element, unit) => React.element =
    "Suspense"
}

module Lazy = {
  module type T = {
    let make: React.component<unit>
    let makeProps: unit => unit
  }
  type dynamicImport = Js.Promise.t<{"make": React.component<unit>}>

  @module("react")
  external lazy_: (unit => Js.Promise.t<{"default": React.component<unit>}>) => React.component<unit> =
    "lazy"

  let make: (unit => dynamicImport) => module(T) = func => {
    let lazyPromise = lazy_(() => func()->Js.Promise.then_(comp => {
        Js.Promise.resolve({"default": comp["make"]})
      }, _))

    module Return = {
      let make = lazyPromise
      let makeProps = () => ()
    }

    module(Return)
  }
}

@val
external import_: string => Lazy.dynamicImport = "import"
