.PHONY: all
all: help

.PHONY: help
help:
	@echo 'Makefile help:                                                              '
	@echo '                                                                            '
	@echo '   lint              Run linters                                            '
	@echo '   requirements      Compile files with requirements                        '
	@echo '   tests             Run unit tests                                         '
	@echo '   run               Run web app                                            '

.PHONY: tests
tests:
	@PYTHONPATH=. pytest tests -W ignore -v --cov

.PHONY: requirements
requirements:
	@pip-compile requirements/dev.in -o requirements/dev.txt
	@pip-compile requirements/prod.in -o requirements/prod.txt

.PHONY: lint
lint:
	@flake8 service tests
	@pylint --exit-zero --rcfile setup.cfg service tests

.PHONY: run
run:
	uvicorn service.main:app
