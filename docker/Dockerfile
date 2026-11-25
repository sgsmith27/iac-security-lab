# Ejemplo deliberadamente inseguro. Solo analisis estatico.
FROM python:latest
ADD . /app
RUN pip install -r /app/requirements.txt
ENV DB_PASSWORD=SuperSecreta123
EXPOSE 22 8000
CMD python /app/app.py
