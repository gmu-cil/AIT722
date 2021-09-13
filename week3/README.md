# Cultural Diversity Measures

See the `cultural_diversity.R` for the examples. This example uses Meeupt data randomly sampled for Washington D.C.

Cultural characteristics could be classified based on (1) the unit of analysis and (2) ontological models.

### Unit of analysis in cultural dimensions
- National level: how much a country is diverse in consuming cultural goods? Or how much a country is closed or open to different kinds of cultural goods?
- Community- or city-level: how much a city is diverse in consuming cultural goods? Or how much a neighborhood has a cultural asset or capital compared to other regions?
- Individual level: how much an individual is omnivorous in consuming cultural goods? Or how much an individual's cultural taste is atypical compared to other mainstream cultural trends? 

### Ontological models
- Entropy-based models: quantifying diversity of concentration using entropy-based measures (e.g., Shannon, Simpson, Rao-Stirling, etc.)
- Network-based models: quantifying diversity, betweenness, popularity, closeness, etc. by modeling cultural actors and goods as networks. 


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


