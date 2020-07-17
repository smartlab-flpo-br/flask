#!/bin/bash

export PATH=$PATH:/usr/lib/uwsgi/plugins/
export FLASK_DEBUG=0
export FLASK_APP=/app/main.py

if [ -e $FLASK_APP ] ; then

	if [ "$1" = 'debug' ] ; then
		echo DEBUG mode
        	export FLASK_DEBUG=1
	fi

    if [ "$1" = 'lint' ] ; then
		pip3 install -Iv pylint==2.4.4
        python3 app/test/run_linter.py
	fi

	if [ "$1" = 'test' ] ; then
		# pip3 install -Iv nose2==0.9.1
		apt-get install -y python3-nose
        nose2 --config app/test/nose2.cfg --with-cov --coverage-report xml --coverage-config app/test/coverage/.coveragerc > ${INPUT_DEST}/test.txt 2>&1
	fi

	if [ "$1" = 'uwsgi' ] ; then
		echo uWSGI mode
        	exec uwsgi --ini /etc/uwsgi/conf.d/uwsgi.ini --die-on-term
	fi

	if [ "$1" = 'terminal' ] ; then
		echo TERMINAL mode
        	exec /bin/sh
	fi

    if [ "$1" != 'lint' -a "$1" != 'test' ] ; then
	    exec flask run --host=0.0.0.0 --port=5000
    fi
else
	echo -e "\n Erro: File /app/main.py not found!" 
fi

echo -e "\n ==> Read how to use this in https://github.com/smartlab-flpo-br/flask"
