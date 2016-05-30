#!/bin/bash

if [ -z "$HUGO_BASEURL" ]; then
  echo "You must define HUGO_BASEURL";
  exit 1;
fi

if [ -z "$HUGO_PORT" ]; then
  echo "You must define HUGO_PORT";
  exit 1;
fi

if [ -z "$C9_PORT" ]; then
  echo "You must define C9_PORT";
  exit 1;
fi

if [ ! -e /app/site ]; then
  echo "No /app/site mounted in, copying default example into place"

  mkdir -p /app
  cd /app
  hugo new site site
  mkdir -p /app/site/themes/cocoa
  cd /app/site/themes/cocoa
  wget -qO- https://github.com/nishanths/cocoa-hugo-theme/tarball/master | tar xzv --strip-components=1

  cp -r /app/site/themes/cocoa/exampleSite/content/* /app/site/content

  cat <<EOF > /app/site/config.toml
canonifyurls = true
languageCode = "en-US"
layoutdir = "layouts"
publishdir = "public"
author = "Arthur Dent"
title = "Arthur Dent"
pygmentsuseclasses = true
pluralizelisttitles = false
theme = "cocoa"

[permalinks]
fixed = ":title/"
blog = "blog/:slug/"

[params]
Author = "Arthur Dent"
DateForm = "Jan 2, 2006"
DateFormFull = "Mon Jan 2 2006 15:04:05 MST"
Description = "Don't panic"
Lang = "en"
EOF

fi

/usr/bin/supervisord -c /supervisord.conf
