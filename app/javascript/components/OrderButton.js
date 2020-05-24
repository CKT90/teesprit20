import React from 'react';
import PropTypes from 'prop-types';
import { withStyles } from '@material-ui/core/styles';
import Button from '@material-ui/core/Button';
import nameHOC from './Universal';


export class ButtonOrder extends React.Component {
  render () {
    return (
      <div>
        <form action={"/admin/orders/" + this.props.orderNo} method="post">
          <input name="_method" value="patch" type="hidden" />
          <input value={this.props.value} name="order[order_status_cd]" type="hidden" />
          <input type="hidden" name="authenticity_token" value={this.props.authenticity_token} />
          <Button variant="contained" type="submit" style={{backgroundColor: this.props.color}} >
          {this.props.label}
        </Button>
        </form>
      </div>

    );
  }
}


export default nameHOC(ButtonOrder);