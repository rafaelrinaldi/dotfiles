/**
 * - Prompts for module name (default to current folder name)
 * - Prompts for module description
 * - Start module at v1.0.0
 * - Default license is MIT
 * - If `npmrc` is available, fill the "author" key
 */

const run = require('child_process').execSync;
const path = require('path');
const home = path.resolve(process.env.HOME);
const cwd = process.cwd().split('/').pop();
const hasCredentials = require('fs').existsSync(`${home}/.npmrc`);

var manifest = {
  name: prompt('Module name', cwd, name => name),
  description: prompt('Description', '', description => description),
  version: '1.0.0',
  license: 'MIT'
};

if (hasCredentials) {
  const npmrc = run(`cat ${home}/.npmrc`).toString();

  manifest = Object.assign({
    author: {
      name: /name=(.*)$/m.exec(npmrc)[1],
      email: /email=(.*)$/m.exec(npmrc)[1],
      url: /url=(.*)$/m.exec(npmrc)[1]
    }
  }, manifest);
}

module.exports = manifest;
