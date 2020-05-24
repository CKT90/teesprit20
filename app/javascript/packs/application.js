var componentRequireContext = require.context("components", true)
var ReactRailsUJS = require("react_ujs")
ReactRailsUJS.useContext(componentRequireContext)

require("chartkick")
require("chart.js")

import React from 'react';
import { render } from 'react-dom';

//render(<App />, document.querySelector('#app'));


function App() {
  return (
    <MuiThemeProvider theme={theme}>
      <Root />
    </MuiThemeProvider>
  );
}



