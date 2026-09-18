#!/usr/bin/env bash
# Publica a ficha da carteira num repositorio publico da organizacao.
# Rode com:  bash ~/Downloads/sentinela-ficha/publicar.sh
set -e

DONO="${1:-sentinela-invest}"     # organizacao (ou seu usuario, se preferir)
REPO="ficha"

cd "$(dirname "$0")"

echo "==> criando $DONO/$REPO como repositorio PUBLICO e subindo a ficha"
gh repo create "$DONO/$REPO" --public --source . --push \
  --description "Ficha da carteira do Sentinela.Invest"

echo
echo "==> ligando o GitHub Pages (branch main, raiz do repositorio)"
gh api -X POST "repos/$DONO/$REPO/pages" \
  -f "source[branch]=main" -f "source[path]=/" >/dev/null 2>&1 \
  || echo "(Pages ja estava ligado, ou precisa ser ligado na mao em Settings > Pages)"

echo
echo "==> pronto. O endereco fica:"
echo "    https://$DONO.github.io/$REPO/"
echo "    (o GitHub leva 1 a 2 minutos pra publicar da primeira vez)"
