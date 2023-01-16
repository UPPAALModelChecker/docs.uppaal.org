This repo contains the source for building the UPPAAL help files. 
The documentation is automatically build and published to https://docs.uppaal.org.

If you wish to contribute to the documentation please fork the repo and submit a pull-request. 
Please notice, by creating a pull-request you give the UPPAAL development team permission to use and distribute you changes together with UPPAAL, this includes the commercial versions of UPPAAL.
 

# Build pages locally

  * get hugo: https://gohugo.io/getting-started/installing 

  * Checkout source: `git clone git@github.com:UPPAALModelChecker/docs.uppaal.org.git`
  * `cd docs.uppaal.org`
  * `hugo serve`

  * Open http://localhost:1313


# Release

## Updated theme

git subtree pull --prefix=themes/hugo-theme-learn https://github.com/matcornic/hugo-theme-learn.git master --squash


## Build for Offline
We build the documentation of offline reading and includes it with the UPPAAL distribution. To build the offline version please notice the following changes:

### General config
Change config to:
```
baseURL = "."
canonifyURLs = "true"
uglyURLs="true"
relativeURLs="true"
```

### Update Search
Some browsers CORS settings does not allow loading json via file:// protocol. To circumvent this issue we inline the 
content of index.json into search.js function initLunr. Update search.js - initLunr to contain the following: 
``` js
function initLunr() {
    if (!endsWith(baseurl,"/")){
        baseurl = baseurl+'/'
    };

    #pagesIndex = [{...}...]
    pagesIndex = <Content of index.json>;
    
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
```
