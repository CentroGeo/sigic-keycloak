// keycloak/stylelint.config.js
module.exports = {
    extends: [
        "stylelint-config-standard",
    ],
    rules: {
        // Permitir custom properties tipo PatternFly (con mayúsculas y guiones dobles)
        "custom-property-pattern": "^--pf-v5-[a-zA-Z0-9_\\-]+$",

        // Otras reglas útiles que no molestan a PatternFly
        "selector-class-pattern": null,
        "property-no-vendor-prefix": null,
        "value-no-vendor-prefix": null,
        "selector-pseudo-element-colon-notation": "double",
        "declaration-empty-line-before": null,

        // Desactiva reglas innecesarias o problemáticas para CSS generados
        "declaration-block-single-line-max-declarations": null,
        "declaration-block-no-redundant-longhand-properties": null,
        "selector-not-notation": null,
        "no-descending-specificity": null
    }
};
