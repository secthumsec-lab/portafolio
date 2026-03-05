# 🎨 Front-End Development Projects

![React](https://img.shields.io/badge/React-18-61DAFB?style=for-the-badge&logo=react&logoColor=white)
![Vite](https://img.shields.io/badge/Vite-4.0-646CFF?style=for-the-badge&logo=vite&logoColor=white)
![JavaScript](https://img.shields.io/badge/JavaScript-ES6-F7DF1E?style=for-the-badge&logo=javascript&logoColor=black)
![CSS3](https://img.shields.io/badge/CSS3-1572B6?style=for-the-badge&logo=css3&logoColor=white)

## 📋 Descripción

Colección de proyectos de desarrollo front-end modernos utilizando las últimas tecnologías web. Este directorio contiene aplicaciones React, componentes reutilizables y experimentos con frameworks JavaScript actuales.

## 🎯 Tecnologías Principales

### Frameworks y Librerías
- ⚛️ **React 18** - Framework principal
- ⚡ **Vite** - Build tool ultrarrápido
- 🎨 **Styled Components** - CSS-in-JS
- 🔄 **React Router** - Navegación SPA
- 📊 **Chart.js/Recharts** - Visualización de datos

### Lenguajes y Estándares
- 📜 **JavaScript ES6+** - Sintaxis moderna
- 🎯 **TypeScript** - Tipado opcional
- 🌐 **HTML5** - Estructura semántica
- 🎨 **CSS3** - Animaciones y layouts

### Herramientas de Desarrollo
- 🛠️ **ESLint** - Linting de código
- 🎨 **Prettier** - Formateo automático
- 📦 **npm/yarn** - Gestión de dependencias
- 🧪 **Jest/React Testing Library** - Testing

## 📁 Estructura de Proyectos

### 📱 Aplicaciones Completas

#### `cripto/`
[![React](https://img.shields.io/badge/React-Crypto_App-61DAFB)](cripto/)
[![Vite](https://img.shields.io/badge/Vite-4.0-646CFF)](cripto/)

**Aplicación de Criptomonedas**
- 💰 **Tracking** de precios en tiempo real
- 📈 **Gráficos** de velas (TradingView)
- 📰 **Noticias** del mercado crypto
- 🌍 **Multidioma** (ES/EN/PT)
- 📱 **Responsive** design

**Características técnicas:**
- 🔄 API integration (CoinGecko, NewsAPI)
- 📊 Charts con TradingView
- 🎨 Material-UI components
- 💾 Local storage para favoritos
- 🔍 Búsqueda y filtros avanzados

```bash
cd cripto
npm install
npm run dev
```

### 🧩 Componentes Reutilizables

#### UI Components
- `Button/` - Botones personalizables
- `Modal/` - Modales accesibles
- `Form/` - Formularios con validación
- `Table/` - Tablas con sorting/pagination

#### Business Components
- `CryptoCard/` - Tarjeta de criptomoneda
- `PriceChart/` - Gráfico de precios
- `NewsFeed/` - Feed de noticias
- `Portfolio/` - Dashboard de portafolio

### 🛠️ Utilidades y Hooks

#### Custom Hooks
- `useCryptoData` - Fetch de datos crypto
- `useLocalStorage` - Persistencia local
- `useDebounce` - Debouncing de inputs
- `useIntersectionObserver` - Lazy loading

#### Utilidades
- `formatters.js` - Formateo de números/monedas
- `validators.js` - Validación de inputs
- `api.js` - Cliente HTTP centralizado
- `constants.js` - Configuraciones globales

## 🚀 Inicio Rápido

### Requisitos
- 🟢 **Node.js** >= 16.0
- 📦 **npm** >= 8.0 o **yarn** >= 1.22
- 🌐 **Navegador moderno** (Chrome, Firefox, Safari)

### Instalación General
```bash
# Clonar y navegar
git clone <repo-url>
cd front-end/[project-name]

# Instalar dependencias
npm install
# o
yarn install

# Iniciar desarrollo
npm run dev
# o
yarn dev
```

### Comandos Disponibles
```bash
# Desarrollo
npm run dev          # Servidor de desarrollo
npm run build        # Build de producción
npm run preview      # Preview del build

# Calidad de código
npm run lint         # ESLint
npm run format       # Prettier
npm run type-check   # TypeScript (si aplica)

# Testing
npm run test         # Ejecutar tests
npm run test:watch   # Tests en modo watch
npm run test:coverage # Cobertura de tests
```

## 🎨 Arquitectura y Patrones

### 📁 Estructura de Carpetas
```
src/
├── components/      # Componentes reutilizables
│   ├── ui/         # Componentes base (Button, Input)
│   ├── layout/     # Layout components (Header, Sidebar)
│   └── business/   # Componentes de negocio
├── pages/          # Páginas de la aplicación
├── hooks/          # Custom hooks
├── utils/          # Utilidades y helpers
├── services/       # APIs y servicios externos
├── styles/         # Estilos globales y themes
├── types/          # Definiciones TypeScript
└── constants/      # Constantes y configuraciones
```

### 🔄 Patrones Implementados

#### Componentes
- **Atomic Design**: Atoms → Molecules → Organisms
- **Compound Components**: API flexible para componentes complejos
- **Render Props**: Compartir lógica entre componentes

#### Estado
- **Context API**: Estado global simple
- **Custom Hooks**: Lógica reutilizable
- **Local State**: useState para estado local

#### Estilos
- **CSS Modules**: Estilos scoped
- **Styled Components**: CSS-in-JS
- **Design System**: Tokens de diseño consistentes

## 📱 Responsive Design

### Breakpoints
- 📱 **Mobile**: < 768px
- 📟 **Tablet**: 768px - 1024px
- 💻 **Desktop**: > 1024px

### Estrategias
- **Mobile-first**: Diseño comenzando por móvil
- **Fluid typography**: Texto adaptable
- **Flexible layouts**: Grid y Flexbox
- **Progressive enhancement**: Funcionalidades por capas

## ♿ Accesibilidad (a11y)

### WCAG 2.1 AA Compliance
- 🎯 **Semántica HTML** correcta
- ⌨️ **Navegación por teclado** completa
- 📢 **Screen readers** support
- 🎨 **Contraste de color** adecuado
- 📏 **Tamaño de toque** mínimo 44px

### Herramientas
- **axe-core**: Testing automatizado
- **Lighthouse**: Auditoría de accesibilidad
- **NVDA/JAWS**: Testing con screen readers

## 🧪 Testing Strategy

### Unit Tests
```javascript
// Ejemplo con Jest + React Testing Library
import { render, screen } from '@testing-library/react'
import { CryptoCard } from './CryptoCard'

test('renders crypto information', () => {
  render(<CryptoCard crypto={mockCrypto} />)
  expect(screen.getByText('Bitcoin')).toBeInTheDocument()
})
```

### Integration Tests
- **Component integration**
- **API calls mocking**
- **User workflows**

### E2E Tests
- **Playwright/Cypress**
- **Critical user journeys**
- **Cross-browser testing**

## 🚀 Despliegue y CI/CD

### Build Optimization
- **Code splitting**: Carga lazy de componentes
- **Tree shaking**: Eliminación de código muerto
- **Asset optimization**: Imágenes y fuentes optimizadas
- **Caching**: Service worker para PWA

### CI/CD Pipeline
```yaml
# GitHub Actions example
- name: Build and Test
  run: |
    npm ci
    npm run lint
    npm run test
    npm run build
```

### Hosting Platforms
- **Vercel**: Para aplicaciones React
- **Netlify**: Con funciones serverless
- **GitHub Pages**: Para proyectos simples
- **AWS S3 + CloudFront**: Infraestructura personalizada

## 📊 Performance

### Métricas Objetivo
- **First Contentful Paint**: < 1.5s
- **Largest Contentful Paint**: < 2.5s
- **First Input Delay**: < 100ms
- **Cumulative Layout Shift**: < 0.1

### Optimizaciones
- **Bundle analysis**: Webpack Bundle Analyzer
- **Image optimization**: Next.js Image o similar
- **Font loading**: Font Display swap
- **Critical CSS**: Above the fold optimization

## 🤝 Contribuir

### Proceso de Desarrollo
1. **Fork** el proyecto
2. Crear rama: `git checkout -b feature/nueva-funcionalidad`
3. **Desarrollar** siguiendo estándares
4. **Testear** thoroughly
5. **Pull Request** con descripción

### Estándares de Código
- 📏 **ESLint + Prettier** configurados
- 🎯 **Conventional commits**
- 📚 **Storybook** para componentes
- 🧪 **Tests** obligatorios

## 📚 Recursos de Aprendizaje

### Documentación Oficial
- [React Docs](https://react.dev/)
- [Vite Guide](https://vitejs.dev/guide/)
- [MDN Web Docs](https://developer.mozilla.org/)

### Comunidades
- 💬 **Reactiflux** Discord
- 📖 **React subreddit**
- 🐙 **GitHub** issues y PRs

## 📞 Soporte

Para soporte técnico:
- 📧 **Issues**: Bugs y feature requests
- 💬 **Discussions**: Preguntas generales
- 📖 **Wiki**: Guías detalladas

---

🎨 **Construye experiencias web modernas con React y Vite**