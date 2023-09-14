
set shell := ["bash", "-uc"]

record:
  for COMMAND in scripts/*; do \
    COMMAND_BASE=$(basename $COMMAND); \
    ttyrec -e "./src/run-script.sh -f $COMMAND" recordings/raw/$COMMAND_BASE.ttyrec; \
    ttygif recordings/raw/$COMMAND_BASE.ttyrec -f; \
    mv tty.gif recordings/$COMMAND_BASE.gif; \
    echo "Moved tty.gif to recordings/$COMMAND_BASE.gif"; \
  done

debug script:
  ./src/run-script.sh -d -f {{script}}

init:
  git submodule update --init --recursive

