FROM python:latest
WORKDIR /app
RUN echo "Hello world!" > index.html
EXPOSE 7000
CMD python -m http.server 7000
