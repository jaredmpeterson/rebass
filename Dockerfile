FROM node:lts-slim as node

COPY . /home/node/html

RUN cd /home/node/html \
    && yarn install \
    && yarn build 

FROM nginx:1.15

COPY --from=node --chown=nginx:nginx /home/node/html/build /usr/share/nginx/html

COPY --from=node /home/node/html/node_modules/@sendoutcards/react-scripts/config/default.conf /etc/nginx/conf.d/default.conf
