import React, { useState, useEffect } from 'react';
import './App.css';

function App() {

  const [items, setItems] = useState([]);

  useEffect(() => {
    fetch('http://localhost:6767')
      .then((res) => res.json())
      .then((data) => setItems(data))
      .catch((err) => console.error("Error fetching backend:", err));
  }, []);

  return (
    <div className="BigContainer">

      <h1 id="MainHeading">SUM BOOKS</h1>

      <p>Some books that probably were the most surprising forq me as a person</p>

      <ul>
        {items.map(item => (
          <li key={item.id}>{item.name}</li>
        ))}
      </ul>

    </div>
  );
}

export default App;