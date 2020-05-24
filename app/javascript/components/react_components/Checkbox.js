import React from 'react';
import axios from 'axios';
import Switch from '@material-ui/core/Switch';
import Button from '@material-ui/core/Button';


export class Checkbox extends React.Component {
	constructor(props){
		super(props);
		this.state = { initialState: false, initialName: [], color: "secondary" };
		this.changeValue = this.changeValue.bind(this);
	}

	componentDidMount () {

		if (this.props.attribute == this.props.falseValue) {
			this.setState({ initialState : false}); //setting the initial state, can use axios detect initial state
			this.setState({ initialName : this.props.falseName });
			this.setState({ color : "secondary"});
		}
		else if (this.props.attribute == this.props.trueValue) {
			this.setState({ initialState : true}); 
			this.setState({ initialName : this.props.trueName });
			this.setState({ color : "primary"});
		};

		//console.log(this.props.order.name);
		/*  comment: this is ajax to get the item. make sure in order_controller (not admin) have /def show/ render json: @order/end/
			axios.get('/orders', {
		    	params: {
		       	  id: this.props.order.id
		      	}
		      })
		  	.then(response => {
	        	alert(response.data);
	        	console.log(response.data);
	      	})
	    */
	}
	
	changeValue(initialState) {
		
		this.setState({ initialState : !this.state.initialState }, function () { //immediately mutate it
			if (this.state.initialState == true) {
				this.setState({ initialName : this.props.trueName });
				this.setState({ color : 'primary'});

				axios({
				  method: 'post',
				  url: this.props.postUrl,
				  data: {
				    status: this.props.trueValue,
				    authenticity_token: document.querySelector("meta[name=csrf-token]").content
				  },
				  headers: {"X-CSRFToken": document.querySelector("meta[name=csrf-token]").content}
				});
			}
			else {
				this.setState({ initialName : this.props.falseName });
				this.setState({ color : 'secondary'});
				axios({
				  method: 'post',
				  url: this.props.postUrl,
				  data: {
				    status: this.props.falseValue,
				    authenticity_token: document.querySelector("meta[name=csrf-token]").content
				  },
				  headers: {"X-CSRFToken": document.querySelector("meta[name=csrf-token]").content}
				});
			}; 
		});
	}

    render() {
	    return (
	        <div>
	          <Switch label={this.props.title} onChange={this.changeValue} checked={this.state.initialState} color="primary"/>
	          <Button variant="contained" color={this.state.color}>{this.state.initialName}</Button>
	        </div> 
	    );
	}
}

export default Checkbox
