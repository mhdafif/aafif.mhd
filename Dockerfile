# # Build stage
# FROM node:22-alpine AS builder

# # Install pnpm
# RUN npm install -g pnpm

# WORKDIR /app

# # Copy package files
# COPY package.json pnpm-lock.yaml* ./

# # Install dependencies
# RUN pnpm install --frozen-lockfile

# # Copy source code
# COPY . .

# # Build the static site
# RUN pnpm run build

# # Production stage with Caddy
# FROM caddy:2-alpine

# # Copy built static files
# COPY --from=builder /app/dist /var/www/aafif.space/dist

# # Expose port 80
# EXPOSE 80

# # Caddy will automatically serve files from /var/www/aafif.space
# syntax=docker/dockerfile:1

# ########################
# # Build Stage (Astro)
# ########################
# FROM node:22-alpine AS builder
# WORKDIR /app

# # Use pnpm via corepack (lighter & reproducible)
# RUN corepack enable && corepack prepare pnpm@10 --activate

# # --- Memory friendly settings ---
# # Limit Node heap to 512MB during build and reduce extra work.
# ENV NODE_OPTIONS="--max-old-space-size=512"
# ENV ASTRO_MINIFY=true

# # 1) Copy lockfile first and pre-fetch deps (improves caching & RAM)
# COPY pnpm-lock.yaml ./
# RUN pnpm fetch

# # 2) Add package.json and install offline from cache
# COPY package.json ./
# RUN pnpm install --offline --frozen-lockfile

# # 3) Copy the source and build
# COPY . .
# # disable sourcemaps explicitly to save memory
# RUN pnpm build


# ########################
# # Runtime Stage (Caddy)
# ########################
# FROM caddy:2-alpine AS runner
# WORKDIR /var/www/aafif.space

# # Your Caddyfile expects /var/www/aafif.space/dist
# COPY --from=builder /app/dist ./dist

# # If you keep your Caddyfile outside the image, remove the next line.
# # If it's in the repo root, this will include it:
# # COPY Caddyfile /etc/caddy/Caddyfile

# EXPOSE 80
# EXPOSE 443

# # CMD ["caddy", "run", "--config", "/etc/caddy/Caddyfile", "--adapter", "caddyfile"]

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
