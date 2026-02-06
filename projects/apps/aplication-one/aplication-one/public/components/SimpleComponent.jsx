import React, { useState } from 'react';

function SimpleComponent() {
  const [inputValue, setInputValue] = useState("");

  const handleClick = () => {
    alert(`Você digitou: ${inputValue}`);
  };

  return (
    <div className="simple-component">
      <h2>Meu Componente Simples</h2>
      <p>Este é um exemplo básico de um componente React.</p>
      <input
        type="text"
        placeholder="Digite algo..."
        value={inputValue}
        onChange={(e) => setInputValue(e.target.value)}
      />
      <button onClick={handleClick}>Enviar</button>
    </div>
  );
}

export default SimpleComponent;
