#!/bin/bash
usage_exit() {
  echo "Usage: $0 [-d] [pull | hugo | publish]" 1>&2
  exit 1
}

serverURL="flutcla.tech"
serverUserName="flutcla.tech"
baseURL="r.flutcla.tech"
devURL="dev.r.flutcla.tech"

while getopts d OPT
do
  case $OPT in
    "d" ) DEV="TRUE" ;;
    \? ) usage_exit;;
  esac
done
if [ "$DEV" = "TRUE" ]; then
  echo 'Development mode ON.'
  currentURL="$devURL"
else
  currentURL="$baseURL"
fi
shift $((OPTIND - 1))

pull () {
  if [ ! -d ./static ]; then
    mkdir ./static
  fi
  if [ ! -e ./static/slides/.git ]; then
    git clone https://github.com/flutcla/slides.git ./static/slides
  fi
  if [ ! -d ./themes ]; then
    mkdir ./themes
  fi
  if [ ! -e ./themes ]; then
    git clone https://github.com/flutcla/hugo-coder.git ./themes
  fi
  git pull
  cd ./static/slides
  git pull
  cd ../../themes/hugo-coder
  git pull
  cd ../../
}

_hugo () {
  if $DEV; then
    gsed -i 's_baseURL = "https://${baseURL}"_baseURL = "https://${devURL}"_g' config.toml
  fi
  rm -rf ./public
  hugo
  rm -rf ./public/slides/.git
  find ./public/slides -name '*.md' | xargs rm
  find ./public/slides/protected -type f -name "*.html" -exec staticrypt {} -o {} password \;
  if $DEV; then
    gsed -i 's_baseURL = "${devURL}"_baseURL = "${baseURL}"_g' config.toml
  fi
}

publish () {
  _hugo
  find ./public -name '*.html' | xargs gsed -i 's_href="/_href="${currentURL}_g'
  find ./public -name '*.html' | xargs gsed -i 's_src="/_src="${currentURL}_g'
  lftp -u ${serverUserName} -e "mirror --delete --parallel=5 -v -R -p -L ./public/ ./${currentURL}/; exit;" ${serverURL}
}

case $1 in
  "pull" ) pull;;
  "hugo" ) _hugo;;
  "publish" ) publish;;
  * ) usage_exit;;
esac
