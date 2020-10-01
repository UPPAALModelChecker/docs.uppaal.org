## Build Page

  * get hugo: https://gohugo.io/getting-started/installing 

  * Checkout source: git clone git@git.its.aau.dk:UPPAAL/docs.uppaal.org.git
  * cd docs.its.aau.dk
  * hugo serve
  * Open http://localhost:1313


## Updated theme

git subtree pull --prefix=themes/hugo-theme-learn https://github.com/matcornic/hugo-theme-learn.git master --squash


### Local search

Update search.js initLunr to contain the following, where <index.json-content> is the content of index.json
`
function initLunr() {
    if (!endsWith(baseurl,"/")){
        baseurl = baseurl+'/'
    };

    #pagesIndex = [{...}...]
    pagesIndex = <index.json-content>;
    
        lunrIndex = lunr(function() {
                this.ref("uri");
                this.field('title', {
		    boost: 15
                });
                this.field('tags', {
		    boost: 10
                });
                this.field("content", {
		    boost: 5
                });
				
                this.pipeline.remove(lunr.stemmer);
                this.searchPipeline.remove(lunr.stemmer);
				
                // Feed lunr with each file and let lunr actually index them
                pagesIndex.forEach(function(page) {
		    this.add(page);
                }, this);
            })
}
`