module.exports = {
  plugins: [
    require("postcss-import"),
    require("postcss-flexbugs-fixes"),
    require("postcss-preset-env")({
      autoprefixer: {
        flexbox: "no-2009"
      },
      stage: 3
    }),
    require("postcss-nested"),
    require("postcss-css-variables"),
    require("postcss-custom-media"),
    require("tailwindcss"),
    require("autoprefixer")
  ]
}
