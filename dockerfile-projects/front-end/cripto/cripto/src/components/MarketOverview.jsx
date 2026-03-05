// src/components/MarketOverview.jsx
import React, { useEffect, useState } from "react";
import { getFearGreed } from "../services/CryptoService";

const MarketOverview = () => {
  const [fearGreed, setFearGreed] = useState(null);

  useEffect(() => {
    const fetchData = async () => {
      const data = await getFearGreed();
      setFearGreed(data);
    };

    fetchData();
  }, []);

  const getColor = (value) => {
    if (value >= 75) return "#22c55e";
    if (value >= 50) return "#84cc16";
    if (value >= 25) return "#f59e0b";
    return "#ef4444";
  };

  if (!fearGreed) return null;

  return (
    <div
      style={{
        background: "#111827",
        padding: "20px",
        borderRadius: "12px",
        margin: "20px",
        textAlign: "center",
      }}
    >
      <h2>Market Sentiment</h2>

      <div
        style={{
          fontSize: "32px",
          fontWeight: "bold",
          color: getColor(Number(fearGreed.value)),
        }}
      >
        {fearGreed.value}
      </div>

      <div>{fearGreed.value_classification}</div>

      <div style={{ fontSize: "12px", opacity: 0.6 }}>
        Fear & Greed Index del mercado cripto global
      </div>
    </div>
  );
};

export default MarketOverview;