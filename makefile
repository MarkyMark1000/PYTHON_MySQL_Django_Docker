#Add any comments on this here

#Ensure the script is run as bash
SHELL:=/bin/bash

#Set help as the default for this makefile.
.DEFAULT: help

.PHONY: clean help venv su

help:
	@echo ""
	@echo "PROJECT HELP:"
	@echo "make               		- this prints out the help for this makefile."
	@echo "make help          		- this prints out the help for this makefile."
	@echo "Clean:"
	@echo "make clean	    		- DANGER - remove .py files, venv, coverage etc."
	@echo "Virtual Env:"
	@echo "make venv	    		- Make the virtual environment."
	@echo "Run:"
	@echo "make run-local-debug	    	- Run project locally in debug mode"
	@echo "make run-local	    		- Run project locally"
	@echo "make run-dock	    		- Run project using docker"


clean:
	@echo ""
	@echo "*** clean ***"
	@echo ""
	(rm -rf venv; rm -rf *.pyc; find . -type d -name  "__pycache__" -exec rm -r {} +; )
	(rm -rf htmlcov; rm -rf .coverag*;)
	(rm -rf .elasticbeanstalk; rm -rf .dockerignore; rm -rf .gitignore;)
	(rm -rf d*.sqlit*; )
	@echo ""

venv:
	@echo ""
	@echo "*** make virtual env ***"
	@echo ""
	(rm -rf venv; python3 -m venv venv; source venv/bin/activate; pip3 install -r requirements.txt; )
	@echo ""

run-local-debug:
	@echo ""
	@echo "*** run project locally in debug mode ***"
	@echo "  (warning no collection of static)"
	@echo ""
	( source venv/bin/activate; export DJANGO_DEBUG='True'; export API_ENVIRONMENT='test'; python3 manage.py collectstatic --noinput; python manage.py makemigrations; python manage.py migrate; python manage.py runserver 8080 --nostatic; )
	@echo ""

run-local:
	@echo ""
	@echo "*** run project locally ***"
	@echo ""
	@echo ""
	( source venv/bin/activate; export DJANGO_DEBUG='False'; export API_ENVIRONMENT='test'; python3 manage.py collectstatic --noinput; python manage.py makemigrations; python manage.py migrate; python manage.py runserver 8080 --nostatic; )
	@echo ""

run-dock:
	@echo ""
	@echo "*** run project locally on docker ***"
	@echo "  (don't forget to clean up images/containers)"
	@echo ""
	@echo ""
	( docker build -t mjw/mysqlsite .; docker run -e DJANGO_DEBUG='False' -e DB_HOST=docker.for.mac.host.internal -p 8080:8080 mjw/mysqlsite; )
	@echo ""
