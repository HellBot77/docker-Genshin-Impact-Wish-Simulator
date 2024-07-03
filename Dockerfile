FROM alpine/git AS base

ARG TAG=latest
RUN git clone https://github.com/Mantan21/Genshin-Impact-Wish-Simulator.git && \
    cd Genshin-Impact-Wish-Simulator && \
    ([[ "$TAG" = "latest" ]] || git checkout ${TAG}) && \
    rm -rf .git

FROM node AS build

WORKDIR /Genshin-Impact-Wish-Simulator
COPY --from=base /git/Genshin-Impact-Wish-Simulator .
RUN yarn && \
    export NODE_ENV=production && \
    yarn build

FROM lipanski/docker-static-website

COPY --from=build /Genshin-Impact-Wish-Simulator/.vercel/output/static .
