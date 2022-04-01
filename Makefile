pull : slides
	git pull
	cd ./static/slides && git pull
	git submodule update --remote

hugo :
	rm -rf ./public
	hugo