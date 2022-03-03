#!/bin/bash

set -e

install_application() {
    # nothing to do currently
    true
}

configure_application() {
  envsubst < /app/imaprelay.cfg.envsubst > /app/imaprelay.cfg
}

clean_pycache() {
    set +e  # Don't truly care if this fails
    find /app -type f -name '*.pyc' -delete 2> /dev/null
    find /app -type d -name '__pycache__' -delete 2> /dev/null
    set -e
}

clean_tmp() {
    set +e  # Don't truly care if this fails
    # nothing to do currently
    set -e
}

create_data_dirs() {
    # nothing to do currently
    true
}

fix_executable_bits() {
    # nothing to do currently
    true
}

verify_installation() {
    source /venv/bin/activate
    install_application
    configure_application
    clean_pycache
    clean_tmp
    create_data_dirs
    fix_executable_bits
}

if [[ -e /app/.empty ]]; then
    echo "WARNING: ================================================="
    echo "WARNING: imaprelay not mounted into /app, app will not run"
    echo "WARNING: ================================================="
else
    verify_installation
fi

set +e

exec "$@"
