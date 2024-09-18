const defaultTheme = require('tailwindcss/defaultTheme')

module.exports = {
  content: [
    './public/*.html',
    './app/helpers/**/*.rb',
    './app/javascript/**/*.js',
    './app/views/**/*.{erb,haml,html,slim}',
    './app/decorators/*.rb'
  ],
  theme: {
    extend: {
      fontFamily: {
        sans: ['Inter var', ...defaultTheme.fontFamily.sans],
      },
    },
  },
  plugins: [
    require('@tailwindcss/forms'),
    require('@tailwindcss/typography'),
    require('@tailwindcss/container-queries'),
  ],
  safelist: [
      "text-sm",
      "font-medium",
      "me-2",
      "px-2.5",
      "py-0.5",
      "rounded",
      { pattern: /bg-(gray|yellow|blue|red|green)-100/ },
      { pattern: /text-(gray|yellow|blue|red|green)-800/ }
  ]
}
