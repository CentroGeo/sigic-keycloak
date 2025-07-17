// keycloak/stylelint.config.js
module.exports = {
    extends: ["stylelint-config-standard-scss"],
    plugins: ["stylelint-scss"],
    rules: {
        "custom-property-pattern": null,
        "declaration-block-no-redundant-longhand-properties": null,
        "declaration-block-single-line-max-declarations": null,
        "value-keyword-case": null,
        "selector-class-pattern": null,
        "property-no-vendor-prefix": null,
        "value-no-vendor-prefix": null,
        "selector-pseudo-element-colon-notation": null,
        "selector-attribute-quotes": null,
        "at-rule-empty-line-before": null,
        "scss/dollar-variable-pattern": null,
        "no-descending-specificity": null,
        "declaration-empty-line-before": null
    }
};
