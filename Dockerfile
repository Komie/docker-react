FROM node:alpine
ENV HTTP_PROXY="http://cdhwg01.prod.prv:80"
ENV HTTPS_PROXY="http://cdhwg01.prod.prv:80"
WORKDIR '/app'
COPY package.json .
RUN npm install
COPY . .
RUN npm run build

FROM nginx
ENV HTTP_PROXY="http://cdhwg01.prod.prv:80"
ENV HTTPS_PROXY="http://cdhwg01.prod.prv:80"
COPY --from=0 /app/build /usr/share/nginx/html

