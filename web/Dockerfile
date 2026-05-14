# ---------- Stage 1: Install dependencies ----------
FROM node:21-alpine AS builder

WORKDIR /usr/src/app

COPY package.json package-lock.json ./
RUN npm ci

COPY server.js ./

# ---------- Stage 2: Production ----------
FROM node:21-alpine

WORKDIR /usr/src/app

# Copy only necessary files
COPY --from=builder /usr/src/app /usr/src/app

# Remove dev dependencies
RUN npm prune --production

EXPOSE 5000

CMD ["npm", "start"]