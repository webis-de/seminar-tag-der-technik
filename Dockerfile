FROM ghcr.io/coder/code-server:latest

USER root
RUN <<EOF
apt-get update
apt install -y texlive-full latexmk
EOF

RUN apt install -y python3-pip

RUN <<EOF
pip3 install openai ipywidgets ipykernel --break-system-packages
EOF

USER coder
WORKDIR /home/coder
COPY <<EOF ./.config/code-server/config.yaml
bind-addr: 127.0.0.1:8080
auth: password
password: c7b0a
cert: false
EOF

COPY --chown=coder:coder docker-content/tag-der-technik ./tag-der-technik

WORKDIR tag-der-technik
EXPOSE 8080