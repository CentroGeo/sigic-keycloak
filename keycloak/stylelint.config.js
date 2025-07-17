// keycloak/stylelint.config.js
module.exports = {
  extends: [
    "stylelint-config-standard",
    "stylelint-config-prettier"
  ],
  rules: {
    // Permitir custom properties tipo PatternFly (con mayúsculas y guiones dobles)
    "custom-property-pattern": "^--[a-zA-Z0-9-]+$",

    // Otras reglas útiles que no molestan a PatternFly
    "selector-class-pattern": null,
    "property-no-vendor-prefix": null,
    "value-no-vendor-prefix": null,
    "selector-pseudo-element-colon-notation": "double",
    "declaration-empty-line-before": null
  }
};
