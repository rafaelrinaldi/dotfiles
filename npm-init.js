/**
 * - Prompts for module name
 * - Prompts for module description
 * - Start module at v1.0.0
 * - Default license is MIT
 */
module.exports = {
  name: prompt('Module name', '', name => name),
  description: prompt('Description', '', description => description),
  version: '1.0.0',
  license: 'MIT'
};
