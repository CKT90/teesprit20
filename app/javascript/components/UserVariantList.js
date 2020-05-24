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
import EmailIcon from '@material-ui/icons/Email';
import { MuiThemeProvider, createMuiTheme, withStyles } from '@material-ui/core/styles';
import nameHOC from './Universal';
import CardMedia from '@material-ui/core/CardMedia';


export class SimpleCard extends React.Component {
 
render () {
  return (
   
    <div style={{ marginTop: 5 }} >

      <Card style={{ display: 'flex', justifyContent: 'space-between' }}>

        <CardMedia
          style={{height: 160, width: 160}}
          image={this.props.image}
          title="Live from space album cover"
        />

        <CardContent style={{padding:0, textAlign: 'right'}}>
          <List >
            <ListItem >
              <ListItemText style={{textAlign: 'right'}} primary={<a style={{color: '#F57C00'}} href={this.props.skuLink}>{this.props.SKU}</a>} secondary={ this.props.price + " x " + this.props.quantity} />
            </ListItem>
            <ListItem >
              <ListItemText style={{textAlign: 'right'}} primary="Total Unit Price" secondary={this.props.finalPrice} />
            </ListItem>
          </List>
        </CardContent>
      </Card>

    </div>
     
  );
}
}


export default nameHOC(SimpleCard);