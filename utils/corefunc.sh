function CHECK_COMMANDS() {
    for COMMAND in "$@"; do
        if ! command -v $COMMAND > /dev/null; then
            echo "$COMMAND: command not found. Was the _subtype common library properly sourced?"
            exit 1
        fi
    done
}