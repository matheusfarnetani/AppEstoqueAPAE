// tailwind.config.js
module.exports = {
  content: ["./src/**/*.{html,ts}"], // ajuste conforme necessário
  theme: {
    extend: {
      backgroundImage: {
        'custom-gradient': ' linear-gradient(45deg,  rgb(162, 208, 252)  50%, rgb(234, 238, 250) 90% )'
      },
    },
  },
  plugins: [],
}
