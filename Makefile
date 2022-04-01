pull :
	git pull
	cd ./static/slides
	git pull
	cd ../../
	git submodule update --remote

hugo :
	rm -rf ./public
	hugo