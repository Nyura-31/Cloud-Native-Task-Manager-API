FROM node:24-alpine

WORKDIR /app

ENV NODE_ENV=production

# Copy dependency manifests first so this layer can be reused when source changes.
COPY package*.json ./
RUN npm ci --omit=dev && npm cache clean --force

COPY src ./src

USER node

EXPOSE 3000

CMD ["npm", "start"]
