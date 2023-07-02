docker run -d \
    --name shlink-web-client \
    -p 8989:80 \
    -e SHLINK_SERVER_URL=<SERVER_URL> \
    -e SHLINK_SERVER_API_KEY=<GENERATED_API_KEY> \
    --restart unless-stopped \
    shlinkio/shlink-web-client
