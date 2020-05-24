import React from 'react';
import PropTypes from 'prop-types';
import Card from '@material-ui/core/Card';
import CardActions from '@material-ui/core/CardActions';
import CardContent from '@material-ui/core/CardContent';
import Button from '@material-ui/core/Button';
import Typography from '@material-ui/core/Typography';
import List from '@material-ui/core/List';
import ListItem from '@material-ui/core/ListItem';
import ListItemText from '@material-ui/core/ListItemText';
import Avatar from '@material-ui/core/Avatar';
import AddIcon from '@material-ui/icons/Add';
import ForwardIcon from '@material-ui/icons/Forward';
import nameHOC from './Universal';
import { withStyles } from '@material-ui/core/styles';

const styles = {
  primary: {
    color: '#fff',
  },
  secondary: {
    color: '#fff',
  },
}



export class SimpleCard extends React.Component {

render () {

  return (
    <div>
      <Card style={{backgroundColor: '#3b3b3b', color: '#d8d8d8 '}} >
        <CardContent style={{ padding:0 }} >
          <List style={{ display: 'flex' }}>
            <ListItem>
              <ListItemText classes={{ primary: this.props.classes.primary, secondary: this.props.classes.secondary}} primary="Total Price" secondary={this.props.totalPrice} />
            </ListItem>
            <ListItem>
              <Avatar style={{ backgroundColor: '#fff', color: '#1e98b2', marginRight: '10px' }}>
                <AddIcon/>
              </Avatar>
              <ListItemText classes={{ primary: this.props.classes.primary, secondary: this.props.classes.secondary}} primary="Delivery" secondary={this.props.delivery} />
            </ListItem>
            <ListItem>
              <Avatar style={{ backgroundColor: '#fff', color: '#1e98b2', marginRight: '10px'  }}>
                <ForwardIcon />
              </Avatar>
              <ListItemText classes={{ primary: this.props.classes.primary, secondary: this.props.classes.secondary}} primary="Grand Total" secondary={this.props.grandTotal} />
            </ListItem>
          </List>
        </CardContent>
      </Card>

    </div>
     
  );
}
}


export default nameHOC(withStyles(styles)(SimpleCard));