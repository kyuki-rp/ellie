FROM node:14.15.0

RUN npm install -g npm
RUN npm install -g elm elm-test elm-format
RUN mkdir /elm
WORKDIR /elm

# Run cd elm
# RUN elm init
# RUN elm-test init
# RUN elm reactor

# elm install elm/regex
# elm install mdgriffith/elm-ui
# elm install evancz/elm-playground
# elm-test install avh4/elm-program-test

