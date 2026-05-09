###
### clone repo
###

FROM alpine/git AS clone-stage
ARG TARGETDIR=/src/ufo-pursue-open-atlas
RUN git clone --depth 1 https://github.com/concr/ufo-pursue-open-atlas.git "${TARGETDIR}" && \
    rm -rf "${TARGETDIR}/.git" "${TARGETDIR}/.gitignore"

###
### get dumb-init
###

FROM alpine/curl AS download-stage
ARG TARGETARCH
WORKDIR /tmp
COPY --chmod=0755 ./files/download-dumb-init.sh .
RUN apk add --update --no-cache file && \
    /tmp/download-dumb-init.sh

###
### app image
###

FROM python:3.14-slim-trixie
WORKDIR /usr/app/ufo-pursue-open-atlas
COPY --from=clone-stage /src/ufo-pursue-open-atlas .
COPY --from=download-stage /tmp/dumb-init /usr/local/bin
COPY --chmod=0644 ./files/healthcheck.py .
ARG HEALTHCHECK_URL=http://127.0.0.1:8000/
HEALTHCHECK --interval=30s --timeout=5s --start-period=10s --retries=3 \
    CMD python3 /usr/app/ufo-pursue-open-atlas/healthcheck.py
EXPOSE 8000
ENTRYPOINT [ "dumb-init", "--" ]
CMD [ "python3", "-m", "http.server", "8000", "--directory", "web/" ]
