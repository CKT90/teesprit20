import React from 'react';
import PropTypes from 'prop-types';
import { withStyles } from '@material-ui/core/styles';
import MenuItem from '@material-ui/core/MenuItem';
import TextField from '@material-ui/core/TextField';
import nameHOC from './Universal';
import axios from 'axios';
import Card from '@material-ui/core/Card';
import CardContent from '@material-ui/core/CardContent';
import Checkbox from './react_components/Checkbox';


class Text extends React.Component {
	constructor(props){
		super(props);
		this.state = { remarks: this.props.initial };
		this.handleChange = this.handleChange.bind(this);
	}


  handleChange(event) {
    this.setState({ remarks: event.target.value }, function () { 
		axios({
		  method: 'post',
		  url: this.props.remarkUrl,
		  data: {
		    remarks: this.state.remarks,
		    authenticity_token: document.querySelector("meta[name=csrf-token]").content
		  }
		});
	});
  }

  render() {

    return (
      <Card raised="true" style={{marginTop: 30}}>
        <CardContent >
	      <form style={{display: 'flex'}} noValidate autoComplete="off">
	        <TextField
	          label= {this.props.label}
	          value={this.state.remarks}  
	          multiline
	          fullWidth
	          onChange={this.handleChange}
	          margin="normal"
	        />
	      </form>


	    </CardContent>
        <CardContent>

		<Checkbox attribute={this.props.attribute} trueValue={this.props.trueValue} trueName={this.props.trueName}  falseValue={this.props.falseValue}  falseName={this.props.falseName} title={this.props.title} postUrl={this.props.postUrl} />   	
	    </CardContent>
      </Card>

    );
  }
}

export default nameHOC(Text)
