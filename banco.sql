-- =====================================================
-- Petição Asfalto Já! - Conceição da Aparecida / MG
-- Estrutura completa da tabela: assinaturas
-- =====================================================

-- Criação da tabela principal
CREATE TABLE IF NOT EXISTS assinaturas (
  id                  bigint       GENERATED ALWAYS AS IDENTITY PRIMARY KEY,
  created_at          timestamptz  DEFAULT now() NOT NULL,

  -- Dados do signatário
  nome                text         NOT NULL,
  cpf                 text         NOT NULL,
  telefone            text         NOT NULL,
  localidade          text         NOT NULL,
  municipio           text         NOT NULL,

  -- Consentimento LGPD
  consentimento_cpf   boolean,
  consentimento_at    timestamptz,

  -- Dispositivo
  dispositivo         text,
  navegador           text,
  user_agent          text,

  -- Horário de Brasília (gerado automaticamente pelo banco)
  consentimento_at_br text GENERATED ALWAYS AS (
    to_char(consentimento_at AT TIME ZONE 'America/Sao_Paulo', 'DD/MM/YYYY HH24:MI:SS')
  ) STORED
);

-- Constraint: impede CPF duplicado
ALTER TABLE assinaturas
  ADD CONSTRAINT assinaturas_cpf_unique UNIQUE (cpf);

-- Coluna horário Brasília (caso a tabela já exista e precise adicionar)
-- ALTER TABLE assinaturas
-- ADD COLUMN consentimento_at_br text GENERATED ALWAYS AS (
--   to_char(consentimento_at AT TIME ZONE 'America/Sao_Paulo', 'DD/MM/YYYY HH24:MI:SS')
-- ) STORED;
