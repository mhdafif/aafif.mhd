# ===== BUILD STAGE =====
FROM node:20-alpine AS builder
WORKDIR /app

# Pasang pnpm
RUN corepack enable && corepack prepare pnpm@latest --activate

# Salin dependency files
COPY pnpm-lock.yaml package.json ./
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
