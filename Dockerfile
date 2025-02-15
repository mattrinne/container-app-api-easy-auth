FROM ubuntu:24.04

# install os management packages
RUN apt update
RUN apt install software-properties-common -y

# install python
RUN add-apt-repository ppa:deadsnakes/ppa
RUN apt update
RUN apt install python3.13 python3.13-venv python3-pip -y
RUN update-alternatives --install /usr/bin/python3 python3 /usr/bin/python3.13 0

WORKDIR /opt/app
COPY . /opt/app/

RUN python3 -m venv .venv
RUN chmod 555 .venv/bin/activate
RUN ./.venv/bin/activate
RUN python3 -m pip install -r requirements.txt

EXPOSE 8080
ENTRYPOINT [ "uvicorn", "main:app", "--port", "8080", "--host", "0.0.0.0" ]