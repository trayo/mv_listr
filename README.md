# MV Listr

[![Code Climate](https://codeclimate.com/github/trayo/mv_listr/badges/gpa.svg)](https://codeclimate.com/github/trayo/mv_listr)
[![Circle CI](https://circleci.com/gh/trayo/mv_listr.svg?style=svg)](https://circleci.com/gh/trayo/mv_listr)

### To get started, visit [MV Listr](www.mvlistr.com) and sign in with Twitter.

***
### What is MV Listr?

MV Listr is an app that will keep track of movie recommendations
that you send it by text message. It will accept input in the form
of a movie title, TV series title, or TV series episode name.

It will then find the media you sent it by using the [OMDB Api](omdbapi.com)
database and list the results in a convenient and easy to use format.

The purpose of the app is to build a solo project for Turing School of
Software and Design that is capable of consuming an API.

***
### Setup

1. Clone MV Listr to your local machine with:  
    `git clone https://github.com/trayo/mv_listr.git`

1. Install gems with: `bundle install`

1. Then setup the database: `rake db:setup`

1. Launch the server with: `rails s`

1. Go to `localhost:3000`

***
### Testing

Run `rspec`
