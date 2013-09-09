# sprout-wrap

Prepares a Mac running OS X Mountain Lion for web development at DNA using [soloist](https://github.com/mkocher/soloist) and [Sprout](https://github.com/pivotal-sprout/sprout).

This DNA implementation differs as we not only do Ruby work but a mix of PHP,
Node.js and a variety of other technologies.

## Installation

### 1. Install XCode

[![Xcode - Apple](http://r.mzstatic.com/images/web/linkmaker/badge_macappstore-lrg.gif)](https://itunes.apple.com/us/app/xcode/id497799835?mt=12&uo=4)

### 2. Install Command Line Tools
  
  XCode > Preferences > Downloads
  
### 3. Clone this project
  
    git clone https://github.com/dnadesign/sprout-wrap.git
    cd sprout-wrap
  
### 4. Install soloist & and other required gems

    sudo gem install bundler
    bundle

### 5. Run soloist
  
    bundle exec soloist

## Configuration 

Check the soloistc file for the packages in use and site-cookbooks/dna for a 
complete list but at a high level this project adds the following installations
(mostly through homebrew) but a lig

