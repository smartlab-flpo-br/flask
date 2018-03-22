#!/bin/bash

export FLASK_DEBUG=0
export FLASK_APP=/app/main.py

FILE=/app/main.py

if [ -e $FILE ] ; then


	if [ "$1" = 'debug' ] ; then
		echo DEBUG mode
        	export FLASK_DEBUG=1
	fi

	if [ "$1" = 'test' ] ; then
		echo TEST mode
		cd /app
		find ./ -type f -name '*.py' | xargs pylint
		nosetests --traverse-namespace --with-xunit  --exe --py3where .
		exit
	fi

	if [ "$1" = 'terminal' ] ; then
		echo TERMINAL mode
        	exec /bin/sh
	fi

	exec flask run --host=0.0.0.0 --port=5000
else
	echo -e "\n Erro: Arquivo /app/main.py não localizado!" 
fi

echo -e "\n ==> Ambiente para desenvolvimento em Flask no MPT"
echo -e "\n     Flask + Pandas + pyLint + Nose nas últimas versões. Para usar mapeie o diretório APP do seu código."
echo -e "\n     > Executar a aplicação"
echo -e "       docker run -p 1234:5000 -d -v /caminho_completo/app:/app"
echo -e "\n     > Executar a aplicação no modo debug"
echo -e "       docker run -p 1234:5000 -d -v /caminho_completo/app:/app debug"
echo -e "\n     > Executar testes de código"
echo -e "       docker run -p 1234:5000 -v /caminho_completo/app:/app test"
echo -e "\n     > Executar o bash no contêiner"
echo -e "       docker run -p 1234:5000 -it -v /caminho_completo/app:/app /bin/sh \n\n"
