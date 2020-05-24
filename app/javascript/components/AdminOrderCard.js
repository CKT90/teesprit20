import React from 'react';
import PropTypes from 'prop-types';
import { withStyles } from '@material-ui/core/styles';
import Card from '@material-ui/core/Card';
import CardActions from '@material-ui/core/CardActions';
import CardContent from '@material-ui/core/CardContent';
import Typography from '@material-ui/core/Typography';
import nameHOC from './Universal';
import List from '@material-ui/core/List';
import ListItem from '@material-ui/core/ListItem';
import ListItemText from '@material-ui/core/ListItemText';
import Avatar from '@material-ui/core/Avatar';
import EmailIcon from '@material-ui/icons/Email';
import HomeIcon from '@material-ui/icons/Home';
import PersonIcon from '@material-ui/icons/Person';
import PaymentIcon from '@material-ui/icons/Payment';
import Chip from '@material-ui/core/Chip';
import BookmarkIcon from '@material-ui/icons/Bookmark';
import DoneIcon from '@material-ui/icons/Done';
import BlockIcon from '@material-ui/icons/Block';

const styles = {
  cardContent: {
    backgroundColor: '#1e98b2',
    color: '#d8d8d8',
    borderBottom: '0px',
  },
  number: {
    color: '#fff',
    fontWeight: 'bold',
    fontSize: '1.5em',
  },

};

export class SimpleCard extends React.Component {

  constructor(props){
    super(props);
    this.state = { color: [], avatarColor: [], label: [], componentIcon: [] };
  }

  componentWillMount () {
    if (this.props.order.order_status_cd == 0) {
      this.setState({ color : '#161616'});
      this.setState({ avatarColor : '#3d3d3d'});
      this.setState({ label : 'Pending'});
      this.setState({ componentIcon : <BookmarkIcon />});
    }
    else if (this.props.order.order_status_cd == 1) {
      this.setState({ color : '#388E3C'});
      this.setState({ avatarColor : '#43A047'});
      this.setState({ label : 'Approved'}); 
      this.setState({ componentIcon : <DoneIcon />});
    }
    else if (this.props.order.order_status_cd == 2) {
      this.setState({ color : '#C62828'});
      this.setState({ avatarColor : '#D32F2F'});
      this.setState({ label : 'Canceled'});
      this.setState({ componentIcon : <BlockIcon />});
    };
  }


render () {
  return (
    <div>

      <Card>
        <CardContent className={this.props.classes.cardContent}>
          <span className={this.props.classes.number}> {this.props.number} </span>
          <Chip style={{backgroundColor: this.state.color, color: '#fff'}} label={this.state.label} avatar={<Avatar style={{backgroundColor: this.state.avatarColor, color: '#fff' }}>{this.state.componentIcon}</Avatar>} />
           <br  />
          {this.props.date} <br />
        </CardContent>
        <List>
          <ListItem>
            <Avatar style={{ backgroundColor: '#1e98b2', marginRight: '10px' }}>
              <PersonIcon />
            </Avatar>
            <ListItemText primary="Name" secondary={this.props.order.name} />
          </ListItem>
          <ListItem>
            <Avatar style={{ backgroundColor: '#F9A825', marginRight: '10px' }}>
              <HomeIcon/>
            </Avatar>
            <ListItemText  primary="Address" secondary={this.props.order.address} />
          </ListItem>
          <ListItem>
            <Avatar style={{ backgroundColor: '#E64A19', marginRight: '10px' }}>
              <EmailIcon />
            </Avatar>
            <ListItemText primary="Email" secondary={this.props.order.email} />
          </ListItem>
          <ListItem>
            <Avatar style={{ backgroundColor: '#8BC34A', marginRight: '10px' }}>
              <PaymentIcon />
            </Avatar>
            <ListItemText primary="Payment" secondary={this.props.order.pay_type} />
          </ListItem>
        </List>
      </Card>
    </div>
  );
}
}


export default nameHOC(withStyles(styles)(SimpleCard));