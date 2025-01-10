FROM verse_with_more_packages:4.4.1_7
LABEL org.opencontainers.image.created="2024-10-15" \
    org.opencontainers.image.authors="Lucille Delisle" \
    org.opencontainers.image.description="Docker image based on rocker:verse with more packages" \
    org.opencontainers.image.title="verse_with_more_packages" \
    org.opencontainers.image.url="https://github.com/lldelisle/lldelisle-docker/blob/main/verse_with_more_packages" \
    org.opencontainers.image.source="https://github.com/lldelisle/lldelisle-docker/blob/main/verse_with_more_packages/image/Dockerfile"
RUN R -e 'install.packages("pheatmap")'
