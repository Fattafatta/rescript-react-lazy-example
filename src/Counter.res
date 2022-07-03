@react.component
let make = () => {
  let (count, setCount) = React.useState(() => 0)
  <p>
    <button onClick={_e => setCount(count => count + 1)}>
      {`count is: ${count->Belt.Int.toString}`->React.string}
    </button>
  </p>
}
