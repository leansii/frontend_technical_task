# Use a single-stage build
FROM node:22-alpine

WORKDIR /app

COPY package*.json ./

# Install dependencies
RUN npm ci --omit=dev --silent

COPY . .

# Create a non-root user and switch to it
RUN addgroup -S appgroup && adduser -S appuser -G appgroup
USER appuser

EXPOSE 3000

CMD ["node", "src/index.js"]
