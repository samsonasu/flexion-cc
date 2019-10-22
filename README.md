
# Architecture

This app helps teacher evaluate and grade students who are filling out unit conversion worksheets.  The worksheets are drilling conversions for both temperature and volume. 

The teacher boots up the app, inputs the question as well as the student's answer and the the program determines if the student's answer is correct, rounding to the nearest tenth. 

The main unit conversion logic lives in [Converter](./converter.rb), while [Grader](./grader.rb) holds the grading logic.  

The main UI is a [command line interface](./app.rb) that runs on the command line.


# Setup

## Install ruby 
https://rvm.io or similar.  This was written using ruby 2.6.3

## Install dependencies: 

    bundle install

## Run the app: 

    ruby app.rb

## Run tests 

    rspec spec


# Docker setup (If containers are your kind of thing)

    docker build -t samsonasu/gradeapp .
    docker run -it samsonasu/gradeapp


# TODO

List of development tasks I would prioritized next: 
  1. Techdebt - there are multiple ways to initialize Converter, need to consolidate. 
  2. Re-do the user interfact - the menu system is clunky
    - Switch to a free-form /shorthand input, e.g. teacher types "32 F in C = -5 # => INCORRECT"
  3. Make a web interface
    - So many more options not in the CLI for a good UX
  4. Add integration tests - current there are no UI tests for app.rb
    
Features I would add: 
  5. As an instructor, in order to save time, I want to enter all the questions once up front and then enter multiple student reponses
  6. As an instructor, I want the total score for the student's worksheet to be calculated after I enter all their answers. 


