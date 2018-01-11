'use strict';

require('./style.scss');
require('frow/dist/frow.min.css');

require('./index.html');

var Elm = require('../src/Main.elm');
var mountNode = document.getElementById('main');

var app = Elm.Main.embed(mountNode);
