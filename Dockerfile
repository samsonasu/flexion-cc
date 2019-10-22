FROM ruby:2.6 
RUN mkdir -p /u/gradeapp
COPY . /u/gradeapp
WORKDIR /u/gradeapp
RUN ["/usr/local/bin/bundle", "install"]
CMD ["/usr/local/bin/ruby", "/u/gradeapp/app.rb"]