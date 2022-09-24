# Builder Staging => builder 폴더안에 소스코드를 넣는 것이 목표
FROM node:alpine as builder
RUN cd /usr && mkdir app

WORKDIR '/usr/app'
# package.json을 먼저 COPY하고 npm install 함으로써 소스 코드 변경시 불필요하게 npm install 안하도록 설정
COPY package*.json ./
RUN npm install
# 소스코드 COPY
COPY ./ ./

RUN npm run build


# Running Staging
FROM nginx
# builder에서 생성한 파일들(static-html-directory)을 nginx의 기본 폴더에 COPY.
COPY --from=builder /usr/app/build /usr/share/nginx/html

