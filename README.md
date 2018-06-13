## strangerpixel.com ##
A fresh start for my site using [Jekyll](https://github.com/mojombo/jekyll/wiki/configuration), [Daniel McGraw](http://twitter.com/danielmcgraw)'s [Jekyll Base] (https://github.com/danielmcgraw/Jekyll-Base), and [prose.io](http://prose.io/).

# Updates and deployment

`jekyll serve --watch`

Preview at http://localhost:4000. Commit and push to master to deploy. 

# Legacy blog 

To restore:
- rename `posts-old` to `_posts` and run `jekyll serve` to regenerate
- remove the tilde from `~blog.html` to output `_site/blog/index.html`
- edit the `exclude` array in `_config.yml` to restore tags and categories

# TODO

