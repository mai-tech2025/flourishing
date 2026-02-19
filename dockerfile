# --------------------------------------------------
# 1. Base Image
# --------------------------------------------------
FROM nginx:alpine

# --------------------------------------------------
# 2. Maintainer Label (Metadata)
# --------------------------------------------------
LABEL maintainer="yourname@example.com"
LABEL version="1.0"
LABEL description="Demo Nginx Dockerfile with all major instructions"

# --------------------------------------------------
# 3. Environment Variables
# --------------------------------------------------
ENV APP_HOME=/usr/share/nginx/html
ENV NGINX_PORT=80

# --------------------------------------------------
# 4. Working Directory
# --------------------------------------------------
WORKDIR $APP_HOME

# --------------------------------------------------
# 5. Copy Files from Host to Container
# --------------------------------------------------
COPY index.html $APP_HOME/index.html

# --------------------------------------------------
# 6. Add (Supports URLs & Auto-Extract)
# --------------------------------------------------
# Example: adding a compressed file (if available)
# ADD site-content.tar.gz $APP_HOME/

# --------------------------------------------------
# 7. Run Command (Executed at Build Time)
# --------------------------------------------------
RUN echo "Nginx container built successfully!" > /build-info.txt

# --------------------------------------------------
# 8. Expose Port
# --------------------------------------------------
EXPOSE $NGINX_PORT

# --------------------------------------------------
# 9. Volume (Persist Logs)
# --------------------------------------------------
VOLUME ["/var/log/nginx"]

# --------------------------------------------------
# 10. Healthcheck
# --------------------------------------------------
HEALTHCHECK --interval=30s --timeout=5s --start-period=5s --retries=3 \
  CMD wget --quiet --tries=1 --spider http://localhost:$NGINX_PORT || exit 1

# --------------------------------------------------
# 11. User (Security Best Practice)
# --------------------------------------------------
# nginx user already exists in base image
USER nginx

# --------------------------------------------------
# 12. Default Command
# --------------------------------------------------
CMD ["nginx", "-g", "daemon off;"]