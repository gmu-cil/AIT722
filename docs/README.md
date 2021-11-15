# Jekyll Data Management

To initiate the Jekyll Local Server, see the [Jekyll Official Website](https://jekyllrb.com/)
```
gem install bundler jekyll

jekyll new my-awesome-site

cd my-awesome-site

bundle exec jekyll serve
# => Now browse to http://localhost:4000
```

To apply a new Layout, copy the files from `resources` to the `my-awesome-site` folder.
Make any nessary changes in Layout html files.


# Navigation
`_layouts` defines basic HTML structures in the Jekyll page
* `_layouts/default.html`: the overarching page structure, that includes `header`, `contents`, and `footer`.
* `_layouts/home.html`: overrides the homepage contents (which is in `contents` in `default.html`).
* `_layouts/post.html`: overrides the blog posting page.

Markdown files in the root directory (`xx.md`) can define pages with custom sub-URLs. 
In the markdown file, you can specify `title` and `permalink` that are stored in the `site` or `page` variable.
For accessing particular variables, see [https://jekyllrb.com/docs/variables/](https://jekyllrb.com/docs/variables/).

