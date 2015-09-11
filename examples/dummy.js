Engine = require('../index');
util = require('util');

var engine = new Engine();

var validator = engine.compile({
  items: [
    {
      enum: ['a']
    },
    {
      enum: ['b']
    }
  ],
  additionalItems: { enum: [2] }

});

var context = validator(['a','b',2]);

console.log(util.inspect(context, { depth: null }));
