// src/components/CandleChart.jsx
import React from "react";

const CandleChart = ({ prices }) => {
  if (!prices || prices.length === 0) {
    return <div>Cargando gráfico...</div>;
  }

  const width = 220;
  const height = 100;

  const onlyPrices = prices.map((p) => p[1]);

  const min = Math.min(...onlyPrices);
  const max = Math.max(...onlyPrices);

  const points = prices.map((p, i) => {
    const x = (i / prices.length) * width;
    const y = height - ((p[1] - min) / (max - min)) * height;
    return `${x},${y}`;
  });

  const trend =
    ((onlyPrices[onlyPrices.length - 1] - onlyPrices[0]) /
      onlyPrices[0]) *
    100;

  return (
    <div style={{ marginTop: "10px" }}>
      <svg width={width} height={height}>
        <polyline
          fill="none"
          stroke={trend >= 0 ? "lime" : "red"}
          strokeWidth="2"
          points={points.join(" ")}
        />
      </svg>

      <div
        style={{
          color: trend >= 0 ? "lime" : "red",
          fontSize: "12px",
        }}
      >
        Tendencia: {trend.toFixed(2)}%
      </div>
        <polyline
          fill="none"
          stroke={trend >= 0 ? "#22c55e" : "#ef4444"}
          strokeWidth="2"
          style={{ transition: "all 0.5s ease" }}
          points={points.join(" ")}
        />
    </div>
  );
};

export default CandleChart;