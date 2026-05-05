# Production-ready Dockerfile for Node.js + MySQL application

FROM node:20-alpine AS builder

WORKDIR /usr/src/app

# Install dependencies
COPY package.json package-lock.json* ./
RUN npm install --production

# Copy application source
COPY . ./

# Final runtime image
FROM node:20-alpine AS runner
WORKDIR /usr/src/app

# Copy installed dependencies and source files
COPY --from=builder /usr/src/app/node_modules ./node_modules
COPY --from=builder /usr/src/app .

# Runtime configuration
ENV NODE_ENV=production
ENV PORT=3000

EXPOSE 3000

CMD ["node", "server.js"]
