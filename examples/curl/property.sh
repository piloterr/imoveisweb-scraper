#!/usr/bin/env bash
# ImoveisWeb Property API – cURL example
# Usage: PILOTERR_API_KEY=your-key ./property.sh
set -euo pipefail

curl -sS --fail-with-body -G "https://api.piloterr.com/v2/imoveisweb/property" \
  -H "x-api-key: ${PILOTERR_API_KEY}" \
  --data-urlencode query=https://www.imoveisweb.com.br/imoveis/casas/3151/
