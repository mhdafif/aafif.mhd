# Build stage
FROM node:22-alpine AS builder

# Install pnpm
RUN npm install -g pnpm

WORKDIR /app

# Copy package files
COPY package.json pnpm-lock.yaml* ./

# Install dependencies
RUN pnpm install --frozen-lockfile

# Copy source code
COPY . .

# Build the static site
RUN pnpm run build

# Production stage with Caddy
FROM caddy:2-alpine

# Copy built static files
COPY --from=builder /app/dist /var/www/aafif.space/dist

# Expose port 80
EXPOSE 80

# Caddy will automatically serve files from /var/www/aafif.space