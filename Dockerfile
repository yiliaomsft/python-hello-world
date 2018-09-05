FROM python:3.6

RUN mkdir /code

COPY hello-world.py /code

EXPOSE 80

ENTRYPOINT ["python3", "/code/hello-world.py"]
