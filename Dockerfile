# syntax=docker/dockerfile:1

# Build stage: pakai nginx untuk servis statis
FROM nginx:alpine AS builder

# Install dependencies (jika nanti ada build assets)
RUN mkdir -p /usr/share/nginx/html
COPY . /usr/share/nginx/html

# Production stage
FROM nginx:alpine

# Salin dari builder (login.html, dll)
COPY --from=builder /usr/share/nginx/html /usr/share/nginx/html

# Expose port 80
EXPOSE 80

# Ganti index default menjadi login.html
RUN sed -i 's|index  index.html index.htm;|index  login.html index.htm;|' /etc/nginx/conf.d/default.conf

CMD ["nginx", "-g", "daemon off;"]
