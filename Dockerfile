FROM terrillo/python3flask:latest
COPY ./app /app
WORKDIR /app
RUN pip3 install --no-cache-dir -r requirements.txt
ENTRYPOINT ["python"]
CMD ["main.py"]