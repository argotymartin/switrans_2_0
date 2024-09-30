# Etapa de dependencias
FROM harbor.mct.com.co/front-end/flutter:3.22.3 AS deps
WORKDIR /app
COPY pubspec.yaml pubspec.lock ./
RUN flutter pub get
RUN flutter precache

# Etapa de análisis
FROM harbor.mct.com.co/front-end/flutter:3.22.3 AS analyze
WORKDIR /app
COPY --from=deps /app /app
COPY --from=deps /home/flutteruser/.pub-cache /home/flutteruser/.pub-cache
COPY . .
RUN flutter analyze

# Etapa de construcción
FROM harbor.mct.com.co/front-end/flutter:3.22.3 AS build
WORKDIR /app
COPY --from=deps /app /app
COPY --from=deps /home/flutteruser/.pub-cache /home/flutteruser/.pub-cache
COPY . .
RUN export $(cat .env | xargs) && flutter clean && flutter pub get && flutter build web --wasm --no-tree-shake-icons --dart-define=ENV=${ENV}


# Etapa de ejecución
FROM node:slim AS runner
WORKDIR /app
COPY /web/node_server/ .
RUN npm install
COPY --from=build /app/build/web/ ./web/
EXPOSE 3000
ENTRYPOINT ["npm", "start"]




