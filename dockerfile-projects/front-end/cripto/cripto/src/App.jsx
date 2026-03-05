// Componente principal

import React from "react";
import CryptoList from "./components/CryptoList";
import MarketOverview from "./components/MarketOverview";

function App() {
  return (
    <div>
      <h1 style={{ textAlign: "center" }}>
        Monitor de Criptomonedas
      </h1>

      <CryptoList />
      <MarketOverview/>
    </div>
  );
}

export default App;