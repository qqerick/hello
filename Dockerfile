# Stage 1: Build (includes devDependencies like eslint)
FROM node:22-alpine AS build

WORKDIR /usr/src/app

# Copy package.json and lock file first
COPY package*.json ./

# Install all deps (including dev)
RUN npm install

# Copy source code
COPY . .

# Run lint in build stage (optional safety net, CI already does this)
RUN npm run lint


# Stage 2: Production runtime
FROM node:22-alpine AS runtime

WORKDIR /usr/src/app

# Only copy production dependencies
COPY package*.json ./
RUN npm install --production

# Copy only necessary files from build stage
COPY --from=build /usr/src/app ./

# Run as non-root user (security best practice)
RUN addgroup -S app && adduser -S app -G app
USER app

ENV NEW_RELIC_NO_CONFIG_FILE=true
ENV NEW_RELIC_DISTRIBUTED_TRACING_ENABLED=true
ENV NEW_RELIC_LOG=stdout
# Expose app port
EXPOSE 3000

# Start the app
CMD ["node", "index.js"]