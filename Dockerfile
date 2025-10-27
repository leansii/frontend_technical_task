# Build stage
FROM node:22.20-alpine AS build

WORKDIR /app

COPY package*.json ./

RUN npm ci --omit=dev --silent

COPY . .

# Final stage
FROM gcr.io/distroless/nodejs20-debian12

WORKDIR /app

COPY --from=build /app ./

# Create a non-root user and switch to it
USER nonroot

EXPOSE 3000

CMD ["index.js"]