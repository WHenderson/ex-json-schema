Engine = require('../index');

e = new Engine();
n = e.normalize({
  multipleOf: 0,
  something: 'woo'
});
console.log('output', n);
