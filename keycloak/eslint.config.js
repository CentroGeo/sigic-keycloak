// eslint.config.js
import js from '@eslint/js';
import globals from 'globals';
import prettier from 'eslint-config-prettier';

/** @type {import("eslint").Linter.FlatConfig[]} */
export default [
  js.configs.recommended,
  {
    name: 'keycloak-theme-js',
    files: ['keycloak/themes/sigic/**/*.js'],
    languageOptions: {
      ecmaVersion: 2022,
      sourceType: 'module',
      globals: {
        ...globals.browser,
        Keycloak: 'readonly',
        // agrega más si lo necesita tu theme
      },
    },
    rules: {
      'no-var': 'warn',
      'prefer-const': 'warn',
      'no-console': 'warn',
      'no-alert': 'warn',
      'no-unused-vars': ['warn', { args: 'none', ignoreRestSiblings: true }],
      'prefer-arrow-callback': 'warn',
      'no-useless-escape': 'warn',
      'no-redeclare': 'warn',
      'no-prototype-builtins': 'warn',
      'no-undef': 'warn',
      'no-empty': 'warn',
      'no-fallthrough': 'warn',
      'no-cond-assign': 'warn',
      'no-func-assign': 'warn',
      'no-unsafe-optional-chaining': 'warn',
      'no-control-regex': 'warn',
      'no-self-assign': 'warn',
      'no-misleading-character-class': 'warn'
    },
  },
  prettier,
];
