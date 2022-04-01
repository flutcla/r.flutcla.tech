./static/slides/.git :
	cd ./static && git clone https://github.com/flutcla/slides.git

pull : ./static/slides/.git
	git pull
	cd ./static/slides && git pull
	git submodule update --remote

hugo :
	rm -rf ./public
	hugo