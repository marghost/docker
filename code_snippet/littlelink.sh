echo "Please enter your google analytics tracking id"
read GKEY

docker run -d \
  --name=littlelink-server \
  -p 80:3000 \
  -e META_TITLE='Marghost' \
  -e META_DESCRIPTION='Cybersecurity professionnal | Retro gamer | SMB Thinkerer | Old devices restoration | IoT/IIoT | Homelab | ⚜️ 🍁 | Geek' \
  -e META_AUTHOR='Marghost' \
  -e LANG=en \
  -e META_INDEX_STATUS='noindex' \
  -e THEME='Dark' \
  -e GA_TRACKING_ID=$GKEY \
  -e BUTTON_ORDER='MICRO_BLOG,GITHUB,TWITTER,INSTAGRAM,EMAIL' \
  -e FAVICON_URL='https://pbs.twimg.com/profile_images/1485603469037875200/qWu5PSZD_200x200.jpg' \
  -e AVATAR_URL='https://pbs.twimg.com/profile_images/1485603469037875200/qWu5PSZD_200x200.jpg' \
  -e AVATAR_2X_URL='https://pbs.twimg.com/profile_images/1485603469037875200/qWu5PSZD_400x400.jpg' \
  -e AVATAR_ALT='Marghost Profile Pic' \
  -e NAME='Marghost' \
  -e BIO='Hey! Here are the places where you can connect with me!' \
  -e MICRO_BLOG='https://www.thegeekghost.com/' \
  -e GITHUB='https://github.com/marghost' \
  -e TWITTER='https://twitter.com/marghost' \
  -e INSTAGRAM='https://www.instagram.com/marghost/' \
  -e EMAIL='me@thegeekghost.com' \
  -e FOOTER='Marghost © 2023' \
  --restart unless-stopped \
  ghcr.io/techno-tim/littlelink-server:latest
