#!/bin/bash

export FLASK_DEBUG=0
export FLASK_APP=/app/main.py

if [ "$1" = 'compose' ] ; then
	echo "Docker compose mode... the Flask isn't necessary, killing it."
       	exit 0
fi

if [ -e $FLASK_APP ] ; then

	if [ "$1" = 'debug' ] ; then
		echo DEBUG mode
        	export FLASK_DEBUG=1
	fi

	if [ "$1" = 'test' ] ; then
		echo TEST mode
		cd /app
		find ./ -type f -name '*.py' | xargs pylint
		nosetests --traverse-namespace --with-xunit --xunit-file=/tmp/nosetests.xml --exe --py3where .
	fi

	if [ "$1" = 'terminal' ] ; then
		echo TERMINAL mode
        	exec /bin/sh
	fi

	exec flask run --host=0.0.0.0 --port=5000
else
	echo -e "\n Erro: File /app/main.py not found!" 
fi

echo -e "\n ==> Environment for development in Flask in MPT"
echo -e "\n     > Run app (the main file must be named as main.py)"
echo -e "       docker run -p 8080:5000 -d -v /path/app:/app"
echo -e "\n     > Run app in debug mode"
echo -e "       docker run -p 8080:5000 -d -v /path/app:/app debug"
echo -e "\n     > Run tools to test code quality"
echo -e "       docker run -p 8080:5000 -v /path/app:/app test"
echo -e "\n     > Run terminal in containerr"
echo -e "       docker run -p 8080:5000 -it -v /path/app:/app terminal \n\n"
