import React, { useState, useEffect } from 'react';
import './App.css'; // make sure to include your CSS file

function App() {
  const [message, setMessage] = useState('');

  useEffect(() => {
    fetch('http://localhost:5000') // match backend port
      .then((response) => response.text())
      .then((data) => setMessage(data))
      .catch((err) => console.error("Error fetching backend:", err));
  }, []);

  return (
    <div className="BigContainer">
      <img src="pic.jpg" alt="Profile illustration" className="profile-image" />

      <h1 id="MainHeading">Name: Azan</h1>

      <div>
        <span className="bold">Spawn Date: </span>
        <span>18 Sept 2005</span>
      </div>

      <p>Have undiagnosed ADHD with strong problem solving abilities.</p>

      <div>
        <h2 id="MainHeading">Goals in Life</h2>
        <ul id="listitems">
          <li>MONEY</li>
          <li>FOOTBALL</li>
          <li>DID I MENTION MONEY</li>
        </ul>
      </div>


    </div>
  );
}

export default App;