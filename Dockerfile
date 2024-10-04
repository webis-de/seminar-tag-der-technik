FROM ghcr.io/coder/code-server:4.92.2-39

USER root
RUN <<EOF
dnf install -y texlive-scheme-full latexmk
EOF

RUN dnf install -y pip

RUN <<EOF
pip install openai
EOF

USER coder
WORKDIR /home/coder
COPY <<EOF ./.config/code-server/config.yaml
bind-addr: 127.0.0.1:8080
auth: password
password: c7b0a2d07c022ff8270686bc
cert: false
EOF

ENV TEXINPUTS="/home/coder/.texpackages:"

COPY --chown=coder:coder docker-content/tag-der-technik ./tag-der-technik
COPY --chown=coder:coder docker-content/latex-template /home/coder/.texpackages/

WORKDIR tag-der-technik
EXPOSE 8080