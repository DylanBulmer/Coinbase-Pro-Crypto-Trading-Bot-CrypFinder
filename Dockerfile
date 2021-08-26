# Install dependencies only when needed
FROM node:alpine AS deps
# Check https://github.com/nodejs/docker-node/tree/b4117f9333da4138b03a546ec926ef50a31506c3#nodealpine to understand why libc6-compat might be needed.
RUN apk add --no-cache libc6-compat
WORKDIR /usr/src
COPY package.json package-lock.json ./
RUN npm ci

# Production image, copy all the files and grab dependencies
FROM node:alpine AS runner
WORKDIR /usr/src
COPY . .
COPY --from=deps /usr/src/node_modules ./node_modules

# Set env to production mode
ENV NODE_ENV production

# New data directory
RUN mkdir data

# Create a new user and groud to avoid using root user
RUN addgroup -g 1001 -S crypfinder
RUN adduser -S crypfinder -u 1001
RUN chown -R crypfinder:crypfinder /usr/src
USER crypfinder

# Run the bot
CMD ["npm", "start"]