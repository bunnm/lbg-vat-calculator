#Buld Stage
FROM node:20-alpine as build

WORKDIR /app

COPY package*.json /app/
RUN npm install
COPY . .

RUN npm run build

#Final Output
FROM nginx:alpine
COPY --from=build /app/build /usr/share/nginx/html
COPY nginx/nginx.conf /etc/nginx/nginx.conf

CMD ["nginx", "-g", "daemon off;"]
