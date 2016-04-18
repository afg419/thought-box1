var Links = React.createClass({
  getInitialState(){
    return {links: []};
  },

  componentDidMount(){
    this.getUserLinks();
  },

  setLinksState(data){
    this.setState(data);
  },

  getUserLinks(){
      $.ajax({
        url: '/api/v1/links',
        type: 'GET',
        success: (links) => {
          if(links){
            console.log(links);
            this.setLinksState({links: links});
          } else
            this.setState({message: ""});
          }
        }
      );
  },

  renderLinks(){
    return this.state.links.map(link => {
      return <div key={link.id}><Link content={link}/></div>;
    });
  },

  render(){
    return(
      <div>
        {this.renderLinks()}
      </div>
    );
  }
});
