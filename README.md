# SmartLab Flask

Introduction
============

Flask for SmartLab developers 

==> Environment for development in Flask in MPT

     > Run app (the main file must be named as main.py)
       docker run -p 8080:5000 -d -v /path/app:/app

     > Run app in debug mode
       docker run -p 8080:5000 -d -v /path/app:/app debug

     > Run tools to test code quality
       docker run -p 8080:5000 -v /path/app:/app test

     > Run terminal in containerr
       docker run -p 8080:5000 -it -v /path/app:/app terminal
