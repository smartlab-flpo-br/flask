# SmartLab Flask

Flask for SmartLab developers 

==> Environment for development in Flask in MPT

     > Run app (the main file must be named as main.py)
       docker run -p 8080:5000 -d -v /path/app:/app smartlab/flask

     > Run app in debug mode
       docker run -p 8080:5000 -d -v /path/app:/app smartlab/flask debug

     > Run tools to test code quality
       docker run -p 8080:5000 -v /path/app:/app smartlab/flask test

     > Run terminal in container
       docker run -p 8080:5000 -it -v /path/app:/app smartlab/flask terminal
