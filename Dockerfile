# Build stage
FROM node:20 AS build

WORKDIR /app

COPY package*.json ./

RUN npm install

COPY . .

# Final stage
FROM gcr.io/distroless/nodejs20-debian12

WORKDIR /app

COPY --from=build /app ./

# Create a non-root user and switch to it
USER nonroot

EXPOSE 3000

CMD ["index.js"]