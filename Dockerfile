FROM python:3.8.5
RUN pip install awscli
RUN --mount=type=secret,id=aws,target=/root/.aws/credentials

RUN apt-get update &&\
    apt-get install -y \
    libgomp1 \
    gcc \
    curl \
    git \
    ssh

WORKDIR /app

COPY ./requirements.txt /app/requirements.txt
RUN chmod +x ./entrypoint_setup.sh &&\
    pip install --upgrade pip &&\
    pip install -r requirements.txt

COPY . /app

ENTRYPOINT ["python"]