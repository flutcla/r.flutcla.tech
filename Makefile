./static/slides/.git :
	cd ./static && git clone https://github.com/flutcla/slides.git

./themes/hugo-coder/.git :
	cd ./themes && git clone https://github.com/flutcla/hugo-coder.git

pull : ./static/slides/.git ./themes/hugo-coder/.git
	git pull
	cd ./static/slides && git pull
	cd ./themes/hugo-coder && git pull

hugo :
	rm -rf ./public
	hugo