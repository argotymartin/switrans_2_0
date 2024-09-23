FROM harbor.mct.com.co/front-end/flutter:3.22.3 AS analyze
WORKDIR /app
COPY pubspec.yaml /app/pubspec.yaml
RUN flutter pub get
COPY . .
RUN flutter pub get && flutter analyze

FROM harbor.mct.com.co/front-end/flutter:3.22.3 AS build
WORKDIR /app
COPY --from=analyze /app/pubspec.yaml /app/pubspec.lock* ./
COPY --from=analyze /app/.dart_tool/ ./.dart_tool/
COPY . .
COPY .env .
RUN export $(cat .env | xargs) && flutter build web --wasm --no-tree-shake-icons --dart-define=ENVIRONMENT=${ENVIRONMENT}

FROM node:slim
WORKDIR /app
COPY --from=build /app/build/web/ ./web/
COPY /web/node_server/ .
RUN npm install
EXPOSE 3000
ENTRYPOINT ["npm", "start"]



