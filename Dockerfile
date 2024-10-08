# Etapa de dependencias
FROM harbor.mct.com.co/front-end/flutter:3.24.3 AS deps
WORKDIR /app
COPY pubspec.yaml pubspec.lock ./
RUN flutter pub get
RUN flutter precache

# Etapa de análisis
FROM harbor.mct.com.co/front-end/flutter:3.24.3 AS analyze
WORKDIR /app
COPY --from=deps /app /app
COPY --from=deps /home/flutteruser/.pub-cache /home/flutteruser/.pub-cache
COPY lib lib
COPY analysis_options.yaml analysis_options.yaml
COPY assets assets
RUN flutter analyze

# Etapa de construcción
FROM harbor.mct.com.co/front-end/flutter:3.24.3 AS build
ARG ENV
ENV ENV=${ENV}
WORKDIR /app
COPY assets assets
COPY --from=deps /app /app
COPY --from=deps /home/flutteruser/.pub-cache /home/flutteruser/.pub-cache
COPY lib lib
COPY web web
COPY assets assets
RUN flutter build web --wasm --no-tree-shake-icons --dart-define=ENV=${ENV}


# Etapa de ejecución
FROM nginx:alpine AS runner

RUN rm -rf /usr/share/nginx/html
RUN rm /etc/nginx/conf.d/default.conf
COPY --from=build /app/build/web /usr/share/nginx/html
COPY --from=build /app/build/web/nginx/nginx.conf /etc/nginx/conf.d

EXPOSE 80

CMD [ "nginx","-g", "daemon off;" ]




