#!/bin/sh

echo "::group::Setup Repolinter"
set -euo

echo "[INFO] Installing todogroup/repolinter"
npm install -g log-symbols 
npm install -g todogroup/repolinter 

REPOLINT_ARGS=""

if [ -n "$CUSTOM_REPOLINT_URL" ]; then
  echo "[INFO] Insert CUSTOM configuration url"
  REPOLINT_ARGS="--rulesetUrl '$CUSTOM_REPOLINT_URL'"
elif [ -n "$CUSTOM_REPOLINT_FILE" ]; then
  echo "[INFO] Insert CUSTOM configuration file"
  REPOLINT_ARGS="--rulesetFile '$CUSTOM_REPOLINT_FILE'"
else
  echo "[INFO] Insert default configuration"
  cp /repolinter/repolint.yml .
  REPOLINT_ARGS="--rulesetFile repolint.yml"
fi

echo REPOLINT_ARGS=$REPOLINT_ARGS

if [ -n "$CUSTOM_PATHS" ]; then
  echo "[INFO] Setting custom paths"
  REPOLINT_ARGS="$REPOLINT_ARGS --allowPaths '$CUSTOM_PATHS'"
fi

echo REPOLINT_ARGS=$REPOLINT_ARGS

if [ -n "$REPORT_FORMAT" ]; then
  echo "[INFO] Setting report format"
  REPOLINT_ARGS="$REPOLINT_ARGS --format '$REPORT_FORMAT'"
fi

echo REPOLINT_ARGS=$REPOLINT_ARGS

echo "[INFO] Executing:"
echo "[INFO] repolinter $REPOLINT_ARGS $*"
echo "::endgroup::"

sh -c "repolinter $REPOLINT_ARGS $*"
