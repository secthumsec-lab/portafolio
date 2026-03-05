// src/components/CryptoList.jsx
import React, { useEffect, useState } from "react";
import CryptoCard from "./CryptoCard";
import { getCryptos } from "../services/CryptoService";

const CryptoList = () => {
  const [cryptos, setCryptos] = useState([]);

  useEffect(() => {
    const fetchData = async () => {
      const data = await getCryptos();
      setCryptos(data);
    };

    fetchData();
    const interval = setInterval(fetchData, 10000);
    return () => clearInterval(interval);
  }, []);

  return (
    <div className="crypto-container">
      {cryptos.map((c) => (
        <CryptoCard
          key={c.id}
          id={c.id}
          name={c.name}
          price={c.current_price}
          change={c.price_change_percentage_1h_in_currency}
          price_change_percentage_24h={c.price_change_percentage_24h}
          market_cap={c.market_cap}
          total_volume={c.total_volume}
        />
      ))}
    </div>
  );
};

export default CryptoList;