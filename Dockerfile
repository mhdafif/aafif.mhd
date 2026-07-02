# ===== BUILD STAGE =====
FROM node:22-alpine AS builder
WORKDIR /app

# Husky tidak perlu jalan di dalam build (tidak ada .git)
ENV HUSKY=0

# Salin dependency files dulu (biar cache install optimal)
COPY pnpm-lock.yaml package.json ./

# Pasang pnpm sesuai versi di field "packageManager"
RUN corepack enable
RUN pnpm install --frozen-lockfile

# Salin semua file proyek
COPY . .

# Build Astro → hasil ke /dist
RUN pnpm run build


# ===== RUN STAGE =====
FROM nginx:alpine
# Salin hasil build ke direktori default Nginx
COPY --from=builder /app/dist /usr/share/nginx/html

# (opsional) konfigurasi Nginx untuk SPA routing
RUN printf "server {\n\
  listen 80;\n\
  server_name _;\n\
  root /usr/share/nginx/html;\n\
  location / {\n\
    try_files \$uri \$uri/ /index.html;\n\
  }\n\
}\n" > /etc/nginx/conf.d/default.conf

EXPOSE 80
