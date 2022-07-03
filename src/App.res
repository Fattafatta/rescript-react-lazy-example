@react.component
let make = () => {
  let url = RescriptReactRouter.useUrl()

  let module(CountComp) = Bindings.Lazy.make(() => Bindings.import_("./Counter.bs"))
  
  switch url.path {
    | list{"counter"} => <Bindings.Suspense fallback={"loading..."->React.string}> <CountComp /> </Bindings.Suspense>
    | _ => <Home/>
  }
}

