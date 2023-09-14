
set shell := ["bash", "-uc"]

init:
  git submodule update --init --recursive

record-all:
  for COMMAND in scripts/*; do \
    just record "$COMMAND"; \
  done

record script:
  COMMAND_BASE="$(basename '{{script}}')"; \
  ttyrec -e "./src/run-script.sh -f '{{script}}'" "recordings/raw/$COMMAND_BASE.ttyrec"; \
  ttygif "recordings/raw/$COMMAND_BASE.ttyrec" -f; \
  mv tty.gif "recordings/$COMMAND_BASE.gif"; \
  echo "Moved tty.gif to 'recordings/$COMMAND_BASE.gif'";

run script:
  ./src/run-script.sh -f {{script}}

debug script:
  ./src/run-script.sh -d -f {{script}}
