#!/bin/sh
yq eval-all '. as $item ireduce ({}; . * $item)' "$@"
