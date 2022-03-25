FROM node:16-alpine3.15 as build

WORKDIR /home/user/build

COPY . .
RUN yarn add typescript
RUN node_modules/.bin/tsc

FROM xiangronglin/puppeteer:latest

ENV NOVE_ENV=production
WORKDIR /home/user/app

COPY --from=build "/home/user/build/dist/" "./dist/"
COPY "package.json"  "./"
RUN yarn install && mv node_modules ../ 
# COPY . .

USER user
CMD ["node", "dist/index.js"]
