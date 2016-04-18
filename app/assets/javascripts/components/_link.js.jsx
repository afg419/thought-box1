var Link = React.createClass({
  getInitialState(){
    return {content: this.props.content, editable: false, message: ""};
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
      data: {link: {read: !this.state.content.read}},
      success: (link) => {
        if(link){
          this.setContent(link);
        } else {
            this.setState({message: ""});
          }
        }
      }
    );
  },

  toggleEdit(){
    this.setState({editable: !this.state.editable}, ()=>{console.log("happened");});
  },

  setMessage(msg){
    this.setState({message: "" + msg}, ()=>{console.log("happened");});
  },

  editableEntries(){
    var renderable;
    if(this.state.editable){
      renderable = (<div>
        <input name="title" ref="title" placeholder={this.state.content.title}></input>
        <input name="url" ref="url" placeholder={this.state.content.url}></input>
        <button onClick={this.handleUpdate}>Update link</button>
        </div>);
    } else {
      renderable = (<div>
        <h4>{this.state.content.title}</h4>
        <p>{this.state.content.url}</p>
        </div>);
    }
    return renderable;
  },

  handleUpdate(){
    var title = this.refs.title.value;
    var url = this.refs.url.value;
    $.ajax({
      url: '/api/v1/links/' + this.props.content.id,
      type: 'PATCH',
      data: {link: {title: title, url: url}},
      success: (link) => {
        if(link){
          this.setContent(link);
          this.toggleEdit();
          this.setMessage();
          console.log(link);
        } else {
          this.toggleEdit();
          this.setMessage("" + url + " is an invalid url!");
          console.log("FUCKKK");
          }
        }
      }
    );
  },

  render(){
    return(
      <div className={this.state.content.read} key={this.state.content.id}>
        {this.editableEntries()}
        <p>Read: {""+this.state.content.read}</p>
        <p>{this.state.message}</p>
        <button onClick={this.handleReadUnread}>{this.readUnread()}</button>
        <button onClick={this.toggleEdit}>Edit</button>
      </div>
    );
  }
});
