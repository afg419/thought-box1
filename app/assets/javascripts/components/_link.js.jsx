var Link = React.createClass({
  getInitialState(){
    return {read: this.props.content.read};
  },

  readUnread(){
    return {true: "Mark as unread", false: "Mark as read"}[this.state.read];
  },

  handleReadUnread(){
    $.ajax({
      url: '/api/v1/link/' + this.props.content.id,
      type: 'PATCH',
      success: (link) => {
        if(link){
          console.log(link);
          // this.setLinksState({links: links});
        } else {
            this.setState({message: ""});
          }
        }
      }
    );
  },

  render(){
    return(
      <div key={this.props.content.id}>
      <h4>{this.props.content.title}</h4>
      <p>{this.props.content.url}</p>
      <p>Read: {""+this.state.read}</p>
      <button onClick={this.handleReadUnread}>{this.readUnread()}</button>
      </div>
    );
  }
});
