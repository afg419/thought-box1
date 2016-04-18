var Link = React.createClass({
  getInitialState(){
    return {content: this.props.content};
  },

  readUnread(){
    return {true: "Mark as unread", false: "Mark as read"}[this.state.content.read];
  },

  setContent(content){
    this.setState({content: content});
  },

  handleReadUnread(){
    $.ajax({
      url: '/api/v1/links/' + this.props.content.id,
      type: 'PATCH',
      data: {read: !this.state.content.read},
      success: (link) => {
        if(link){
          this.setContent(link);
          console.log(link);
        } else {
            this.setState({message: ""});
          }
        }
      }
    );
  },

  render(){
    return(
      <div className={this.state.content.read} key={this.state.content.id}>
        <h4>{this.state.content.title}</h4>
        <p>{this.state.content.url}</p>
        <p>Read: {""+this.state.content.read}</p>
        <button onClick={this.handleReadUnread}>{this.readUnread()}</button>
      </div>
    );
  }
});
