FROM nginx:1.27.2-alpine
COPY index.html /usr/share/nginx/html
COPY style.css /usr/share/nginx/html
EXPOSE 80
CMD ["nginx","-g","daemon off;"]