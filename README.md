# SmartLab - flask

Introdução
===========

Docker com Flask para ambientes de desenvolvimento 

Flask + Pandas + pyLint + Nose nas últimas versões. Para usar mapeie o diretório APP do seu código.


Forma de uso
------------
Executar a aplicação::

$ docker run -d -p 1234:5000 -d -v /caminho_completo/app:/app

Executar a aplicação no modo debug::

$ docker run -p 1234:5000 -d -v /caminho_completo/app:/app debug

Executar testes de código::

$ docker run -p 1234:5000 -v /caminho_completo/app:/app test

Abrir o terminal::

$ docker run -p 1234:5000 -v /caminho_completo/app:/app terminal


Versões
=======

* TODO: colocar versões

License
=======

The project is licensed under the GPLv2.

