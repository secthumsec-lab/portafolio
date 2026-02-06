// server.js
import express from "express";
import cors from "cors";

const app = express();
const PORT = 5000;

// Middleware
app.use(cors());          // Permite requests desde cualquier frontend
app.use(express.json());  // Para manejar JSON en POST/PUT

// Rutas de prueba
app.get("/api/items", (req, res) => {
  res.json([{ id: 1, name: "Item 1" }]);
});

app.get("/api/users", (req, res) => {
  res.json([
    { id: 1, name: "Alice" },
    { id: 2, name: "Bob" }
  ]);
});

// Middleware de manejo de errores global
app.use((err, req, res, next) => {
  console.error(err.stack);
  res.status(500).json({ error: 'Algo salió mal en el servidor' });
});

// Iniciar servidor
app.listen(PORT, () => {
  console.log(`Backend corriendo en el puerto ${PORT}`);
});
