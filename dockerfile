FROM nginx:alpine

COPY index.html /usr/share/nginx/html
COPY script.js /usr/share/nginx/html
COPY css/ /usr/share/nginx/html/css/
COPY static/ /usr/share/nginx/html/static/

EXPOSE 80

CMD ["nginx", "-g", "daemon off;"]

