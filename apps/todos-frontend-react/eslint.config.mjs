import nx from '@nx/eslint-plugin';
import baseConfig from '../../eslint.config.mjs';

export default [
  ...baseConfig,
  ...nx.configs['flat/react'],
  {
    files: ['**/*.ts', '**/*.tsx', '**/*.js', '**/*.jsx'],
    globals: {
      window: 'readonly',
      document: 'readonly',
      localStorage: 'readonly',
      navigator: 'readonly',
    },
    // Override or add rules here
    rules: {},
  },
];
