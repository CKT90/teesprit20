import React from 'react';
import { MuiThemeProvider, createMuiTheme, withStyles } from '@material-ui/core/styles';



const nameHoC = (WrappedComponent) => {
	const theme = createMuiTheme({
	  typography: {
	    fontFamily: 'robotol',
	  },
	});

    return class extends React.Component {
        render() {
            return(     	     
                <MuiThemeProvider theme={theme}>
                    <WrappedComponent {...this.props}/>
                </MuiThemeProvider>
            )
        }
    }
};

export default nameHoC