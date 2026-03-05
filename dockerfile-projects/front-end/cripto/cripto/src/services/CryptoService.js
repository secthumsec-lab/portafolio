// src/services/CryptoService.js

const cache = {};

export const getCryptos = async () => {
  try {
    const response = await fetch(
      "https://api.coingecko.com/api/v3/coins/markets?vs_currency=usd&ids=bitcoin,ethereum,solana,tether&price_change_percentage=1h,24h"
    );

    if (!response.ok) throw new Error("Error API markets");

    return await response.json();
  } catch (error) {
    console.error("Error obteniendo datos:", error);
    return [];
  }
};

export const getMarketChart = async (id, vs_currency = "usd", days = 7) => {
  const cacheKey = `${id}-${days}`;

  if (cache[cacheKey]) return cache[cacheKey];

  try {
    const response = await fetch(
      `https://api.coingecko.com/api/v3/coins/${id}/market_chart?vs_currency=${vs_currency}&days=${days}`
    );

    if (!response.ok) throw new Error("Error API market_chart");

    const data = await response.json();
    cache[cacheKey] = data;

    return data;
  } catch (error) {
    console.error("Error obteniendo market chart:", error);
    return null;
  }
};

export const getFearGreed = async () => {
  try {
    const response = await fetch(
      "https://api.coingecko.com/api/v3/coins/markets?vs_currency=usd&ids=bitcoin,ethereum,solana,avalanche-2&price_change_percentage=1h,24h"
    );

    if (!response.ok) throw new Error("Error Fear & Greed");

    const data = await response.json();
    return data.data[0];
  } catch (error) {
    console.error("Error Fear & Greed:", error);
    return null;
  }
};