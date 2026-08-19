-- ============================================================
-- SDTech Soluctions — Migration 001
-- Extensões PostgreSQL necessárias
-- ============================================================
-- Extensões: pgcrypto
--   Função:   gen_random_uuid() — geração segura de UUIDs v4
--   Motivo:   Disponível no PostgreSQL core ≥ 13 via pgcrypto.
--             Preferível a uuid-ossp por não requerer compilação
--             adicional na maioria dos ambientes Docker.
--
-- NOTA: Verificar se extensão já existe antes de criar.
--       Utilizar IF NOT EXISTS para idempotência.
-- ============================================================

BEGIN;

-- Habilita geração segura de UUID v4
CREATE EXTENSION IF NOT EXISTS pgcrypto;

-- Comentário de registro
COMMENT ON EXTENSION pgcrypto IS 'SDTech Soluctions: geração de UUID v4 via gen_random_uuid()';

COMMIT;
