##FROM harbor.mct.com.co/front-end/flutter:3.22.3 AS analyze
FROM flutter-image:3.22.3 AS deps
WORKDIR /app
COPY pubspec.yaml pubspec.yaml
RUN flutter pub get

FROM flutter-image:3.22.3 AS analyze
WORKDIR /app
COPY --from=deps /app/ ./
COPY . .
RUN flutter analyze

##FROM harbor.mct.com.co/front-end/flutter:3.22.3 AS build
FROM flutter-image:3.22.3 AS build
WORKDIR /app
COPY --from=analyze /app/ ./
COPY . .
RUN flutter build web --wasm --no-tree-shake-icons --dart-define=ENV=${ENV}

FROM node:slim AS runner
WORKDIR /app
COPY /web/node_server/ .
RUN npm install
COPY --from=build /app/build/web/ ./web/
EXPOSE 3000
ENTRYPOINT ["npm", "start"]



