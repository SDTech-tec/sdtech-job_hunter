#!/usr/bin/env bash
# ============================================================
# validate-workflows.sh — Valida sintaxe e estrutura dos JSONs de workflows n8n
# SDTech Soluctions — N8N Core V1.0
# ============================================================
set -euo pipefail

SCRIPT_DIR="$(cd "$(dirname "${BASH_SOURCE[0]}")" && pwd)"
WORKFLOWS_DIR="$(dirname "$SCRIPT_DIR")/workflows"

echo "============================================================"
echo " SDTech Soluctions — Validação dos Workflows n8n"
echo "============================================================"
echo " Diretório: $WORKFLOWS_DIR"
echo "============================================================"

PASS=0
FAIL=0

for wf in "$WORKFLOWS_DIR"/*.json; do
    filename=$(basename "$wf")
    echo "🔍 Validando $filename..."

    # Check 1: Validação de sintaxe JSON usando python3
    if python3 -c "import json; json.load(open('$wf'))" 2>/dev/null; then
        echo "   ✅ Sintaxe JSON válida"
    else
        echo "   ❌ Erro de sintaxe JSON em $filename"
        ((FAIL++)) || true
        continue
    fi

    # Check 2: Verificação do nome padronizado "SDTECH — CORE —" ou "SDTECH — WHATSAPP —"
    wf_name=$(python3 -c "import json; print(json.load(open('$wf')).get('name', ''))")
    if [[ "$wf_name" == SDTECH\ —\ CORE\ —* ]] || [[ "$wf_name" == SDTECH\ —\ WHATSAPP\ —* ]]; then
        echo "   ✅ Nomenclatura válida: '$wf_name'"
    else
        echo "   ❌ Nome inválido: '$wf_name' (deve iniciar com 'SDTECH — CORE —' ou 'SDTECH — WHATSAPP —')"
        ((FAIL++)) || true
    fi

    # Check 3: Presença de nós e conexões
    nodes_count=$(python3 -c "import json; print(len(json.load(open('$wf')).get('nodes', [])))")
    if [[ "$nodes_count" -gt 0 ]]; then
        echo "   ✅ Contém $nodes_count nós configurados"
        ((PASS++)) || true
    else
        echo "   ❌ Nenhum nó encontrado no workflow"
        ((FAIL++)) || true
    fi
done

echo ""
echo "============================================================"
echo " Resultado da Validação: $PASS validados com sucesso | $FAIL falhas"
echo "============================================================"

if [[ "$FAIL" -gt 0 ]]; then
    exit 1
fi
