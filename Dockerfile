FROM node:18-bullseye

WORKDIR /usr/src/app

RUN npm install -g @angular/cli

COPY . . 

WORKDIR /usr/src/app/angular-site

CMD ng serve --host 0.0.0.0