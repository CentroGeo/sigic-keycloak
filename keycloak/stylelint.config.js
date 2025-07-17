// keycloak/stylelint.config.js
module.exports = {
    extends: ["stylelint-config-standard"],
    rules: {
        // Desactiva validación de pattern para custom properties (PatternFly no cumple regex estándar)
        "custom-property-pattern": null,

        // Compatibilidad con estilo de PatternFly
        "declaration-block-no-redundant-longhand-properties": null,
        "declaration-block-single-line-max-declarations": null,
        "selector-not-notation": null,
        "no-descending-specificity": null,
        "selector-class-pattern": null,
        "property-no-vendor-prefix": null,
        "value-no-vendor-prefix": null,
        "selector-pseudo-element-colon-notation": "double",
        "declaration-empty-line-before": null
    }
}
