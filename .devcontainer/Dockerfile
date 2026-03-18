FROM mcr.microsoft.com/devcontainers/base:ubuntu-22.04

# Install TeX Live (full distribution) + latexmk + bibtex utilities
RUN apt-get update && apt-get install -y --no-install-recommends \
    texlive-full \
    latexmk \
    bibtex2html \
    perl \
    make \
    && apt-get clean \
    && rm -rf /var/lib/apt/lists/*
