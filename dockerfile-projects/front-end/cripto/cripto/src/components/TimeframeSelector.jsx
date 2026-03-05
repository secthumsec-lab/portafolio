// src/components/TimeframeSelector.jsx
import React from "react";

const TimeframeSelector = ({ selected, onChange }) => {
  const options = [1, 7, 30];

  return (
    <div style={{ marginTop: "10px" }}>
      {options.map((d) => (
        <button
          key={d}
          onClick={() => onChange(d)}
          style={{
            marginRight: "5px",
            padding: "4px 8px",
            background: selected === d ? "#00ff99" : "#333",
            color: selected === d ? "#000" : "#fff",
            border: "none",
            borderRadius: "4px",
            cursor: "pointer",
          }}
        >
          {d}D
        </button>
      ))}
    </div>
  );
};

export default TimeframeSelector;