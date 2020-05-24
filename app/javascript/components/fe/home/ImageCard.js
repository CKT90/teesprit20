import React from 'react';
import Card from '@material-ui/core/Card';
import CardActionArea from '@material-ui/core/CardActionArea';
import CardContent from '@material-ui/core/CardContent';
import CardMedia from '@material-ui/core/CardMedia';
import Button from '@material-ui/core/Button';
import { createMuiTheme, responsiveFontSizes, ThemeProvider } from '@material-ui/core/styles';
import Typography from '@material-ui/core/Typography';


let theme = createMuiTheme();
theme = responsiveFontSizes(theme);

export class ImageCard extends React.Component {
  render() {
    return (
      <div onClick={() => window.location = "products/" + this.props.id} style={{display: 'inline-block'}}>
      <Card style={{ maxWidth: 400}}>
        <CardActionArea>
          <CardMedia
            component="img"
            alt={this.props.title}
            image={this.props.image}
            title={this.props.title}
          />
          <CardContent>
            <ThemeProvider theme={theme}>
              <Typography gutterBottom variant="h5" >
                {this.props.title}
              </Typography>
              <Typography variant="body2" color="textSecondary" component="p">
                {this.props.description}
              </Typography>
            </ThemeProvider>
          </CardContent>
        </CardActionArea>
      </Card>
      </div>
    );
  }
}

export default ImageCard