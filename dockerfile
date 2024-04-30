FROM node:latest as build
WORKDIR /app
RUN npm install -g pnpm
COPY package.json ./
COPY . .
RUN pnpm install
RUN pnpm run build


FROM nginx:stable-alpine as production
COPY --from=build /app/dist /usr/share/nginx/html
EXPOSE 80
CMD ["nginx", "-g", "daemon off;"]