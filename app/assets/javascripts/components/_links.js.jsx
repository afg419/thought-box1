var Links = React.createClass({
  getInitialState(){
    return {links: [], sort: this.sortId, filter: this.id};
  },

  swapLink(newLink){
    newLinks = this.state.links.filter(function(link){
      return link.id !== newLink.id;
    });
    this.setState({links: newLinks.concat([newLink])});
  },

  sortId(l1, l2){
    return Date.parse(l2.created_at) - Date.parse(l1.created_at);
  },

  filterBy(type){
    return link => {return link[type[0]] === type[1];};
  },

  sortAlphabetical(l1, l2){
    return l2.title < l1.title;
  },

  id(link){
    return true;
  },

  componentDidMount(){
    this.getUserLinks();
  },

  setLinksState(data){
    this.setState(data);
  },

  handleAlphabet(){
    this.setState({sort: this.sortAlphabetical});
  },

  handleFilter(type){
    return () => this.setState({filter: this.filterBy(type)});
  },

  handleTypeFilter(){
    var queried = this.refs.filterTerm.value;
    this.setState({filter: (link)=>{
      return link.title.indexOf(queried) > -1;
    }});
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
    return this.state.links
      .sort(this.state.sort)
      .filter(this.state.filter)
      .map(link => {
        return <div key={link.id}><Link content={link} setLinksState={this.setLinksState} swapLink={this.swapLink}/></div>;
      });
  },

  resetDisplay(){
    this.setState({sort: this.sortId, filter: this.id});
  },

  render(){
    return(
      <div className="links">
        <input ref="filterTerm" name="filter-term" placeholder="filter by term" onChange={this.handleTypeFilter}></input>
        <button id="sort-alphabetical" onClick={this.handleAlphabet}>Sort Alphabetically</button>
        <button id="filter-read" onClick={this.handleFilter(["read", true])}>Filter by Read</button>
        <button id="filter-unread" onClick={this.handleFilter(["read", false])}>Filter by Unread</button>
        <button id="revert-display" onClick={this.resetDisplay}>Revert to Initial Display</button>
        {this.renderLinks()}
      </div>
    );
  }
});
