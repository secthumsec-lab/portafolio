import { useEffect, useState } from "react";

function App() {
  const [items, setItems] = useState([]);

  useEffect(() => {
    fetch("http://localhost:5000/api/items")
      .then(res => res.json())
      .then(data => setItems(data));
  }, []);

  return (
    <>
      <h1>Full Stack Docker App</h1>
      <ul>
        {items.map(i => (
          <li key={i.id}>{i.name}</li>
        ))}
      </ul>
    </>
  );
}

export default App;
