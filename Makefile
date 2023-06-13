.PHONY: build lint requirements

build:
	esphome compile esphome-air-quality-monitor-esp32.yaml

lint:
	yamllint .

requirements:
	pip3 install wheel
	pip3 install -r requirements.txt