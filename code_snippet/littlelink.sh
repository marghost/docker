echo "Please enter your google analytics tracking id"
read GKEY

docker run -d \
  --name=littlelink-server \
  -p 80:3000 \
  -e META_TITLE='Marghost' \
  -e META_DESCRIPTION='Cybersecurity professionnal | Retro gamer | Electronic Thinkerer | IoT/IIoT | Homelab | ⚜️ 🍁 | Geek' \
  -e META_AUTHOR='Marghost' \
  -e LANG=en \
  -e META_INDEX_STATUS='all' \
  -e THEME='Dark' \
  -e GA_TRACKING_ID=$GKEY \
  -e OG_SITE_NAME='Marghost' \
  -e OG_TITLE='Marghost' \
  -e OG_DESCRIPTION='Marghost' \
  -e OG_URL='http://marg.host' \
  -e OG_IMAGE='https://pbs.twimg.com/profile_images/1485603469037875200/qWu5PSZD_400x400.jpg' \
  -e OG_IMAGE_WIDTH='400' \
  -e OG_IMAGE_HEIGHT='400' \
  -e BUTTON_ORDER='BLOG,GITHUB,TWITTER,INSTAGRAM,EMAIL' \
  -e FAVICON_URL='https://pbs.twimg.com/profile_images/1485603469037875200/qWu5PSZD_200x200.jpg' \
  -e AVATAR_URL='https://pbs.twimg.com/profile_images/1485603469037875200/qWu5PSZD_200x200.jpg' \
  -e AVATAR_2X_URL='https://pbs.twimg.com/profile_images/1485603469037875200/qWu5PSZD_400x400.jpg' \
  -e AVATAR_ALT='Marghost Profile Pic' \
  -e NAME='Marghost' \
  -e BIO='Cybersecurity professionnal | Retro gamer | Electronic Thinkerer | IoT/IIoT | Homelab | ⚜️ 🍁 | Geek' \
  -e CUSTOM_BUTTON_TEXT='Blog' \
  -e CUSTOM_BUTTON_URL='https://www.thegeekghost.com' \
  -e CUSTOM_BUTTON_COLOR='#000000' \
  -e CUSTOM_BUTTON_TEXT_COLOR='#ffffff' \
  -e CUSTOM_BUTTON_ALT_TEXT='Blog' \
  -e CUSTOM_BUTTON_NAME='BLOG' \
  -e CUSTOM_BUTTON_ICON='fas file-alt' \
  -e GITHUB='https://github.com/marghost' \
  -e TWITTER='https://twitter.com/marghost' \
  -e INSTAGRAM='https://www.instagram.com/marghost/' \
  -e EMAIL='me@thegeekghost.com' \
  -e EMAIL_TEXT='Email' \
  -e FOOTER='Marghost © 2023' \
  --restart unless-stopped \
  ghcr.io/techno-tim/littlelink-server:latest
