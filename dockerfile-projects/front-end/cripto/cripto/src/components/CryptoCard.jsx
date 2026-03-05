// src/components/CryptoCard.jsx
import React, { useState, useEffect } from "react";
import { getMarketChart } from "../services/CryptoService";
import CandleChart from "./CandleChart";
import TimeframeSelector from "./TimeframeSelector";

const CryptoCard = ({
  id,
  name,
  price,
  change,
  market_cap,
  total_volume,
  price_change_percentage_24h
}) => {
  const [hover, setHover] = useState(false);
  const [chartData, setChartData] = useState(null);
  const [days, setDays] = useState(7);

  const isPositive = change >= 0;
  const isPositive24 = price_change_percentage_24h >= 0;

  useEffect(() => {
    if (!hover) return;

    const fetchChart = async () => {
      const data = await getMarketChart(id, "usd", days);
      if (data) setChartData(data);
    };

    fetchChart();
  }, [hover, id, days]);

  return (
    <div
      className="card fade-in"
      onMouseEnter={() => setHover(true)}
      onMouseLeave={() => setHover(false)}
    >
      <h3>{name}</h3>

      <div className="price">
        ${price?.toLocaleString()}
      </div>

      <div className={isPositive ? "positive" : "negative"}>
        1h: {isPositive ? "▲" : "▼"} {change?.toFixed(2)}%
      </div>

      <div className={isPositive24 ? "positive" : "negative"}>
        24h: {isPositive24 ? "▲" : "▼"} {price_change_percentage_24h?.toFixed(2)}%
      </div>

      <hr style={{ opacity: 0.1 }} />

      <div className="small-text">
        Market Cap: ${market_cap?.toLocaleString()}
      </div>

      <div className="small-text">
        Volumen 24h: ${total_volume?.toLocaleString()}
      </div>

      {hover && (
        <>
          <TimeframeSelector selected={days} onChange={setDays} />
          {chartData && (
            <CandleChart prices={chartData.prices} />
          )}
        </>
      )}
    </div>
  );
};

export default CryptoCard;