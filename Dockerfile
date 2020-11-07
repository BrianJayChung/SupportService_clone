FROM python:3.6-alpine

RUN apk update && apk add postgresql-dev gcc python3-dev musl-dev bash git libffi-dev make

ENV FLASK_ENV=development
ENV REDIS_URL=redis://support-service-redis.be4fj4.ng.0001.usw2.cache.amazonaws.com:6379
ENV REDIS_HOST=support-service-redis.be4fj4.ng.0001.usw2.cache.amazonaws.com
ENV LD_API_KEY=api-20ed84a1-db37-415d-a81c-5121d9596dbe

# This will need to point to RDS
ENV DATABASE_URL=sqlite:///supportservice.db

# ENV REDIS_HOST=host.docker.internal
# ENV REDIS_URL=redis://host.docker.internal:6379/0

WORKDIR /usr/src/app

COPY . .

RUN pip install -r requirements.txt
RUN pip install --upgrade -e .

EXPOSE 5000
EXPOSE 80

ENTRYPOINT [ "python3" ]

CMD [ "app/factory.py"]