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
      sourceType: 'script',
      globals: {
        ...globals.browser,
        Keycloak: 'readonly',
        // agrega más si lo necesita tu theme
      },
    },
    rules: {
      'no-var': 'error',
      'prefer-const': 'warn',
      'no-console': 'off',
      'no-alert': 'warn',
      'no-unused-vars': ['warn', { args: 'none', ignoreRestSiblings: true }],
      'prefer-arrow-callback': 'warn',
    },
  },
  prettier,
];
