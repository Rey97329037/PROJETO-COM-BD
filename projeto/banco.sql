-- =====================================================================
-- BANCO DE DADOS: cadastro e login de teste
-- Plataforma: Supabase (PostgreSQL + autenticação nativa)
-- Como usar: Supabase > SQL Editor > New query > colar tudo > Run
-- É seguro rodar mais de uma vez (usa IF NOT EXISTS / OR REPLACE).
-- =====================================================================

-- ---------------------------------------------------------------------
-- 1) TABELA DE PERFIS
-- O Supabase já guarda e-mail e senha (com hash) em auth.users.
-- Esta tabela guarda só os dados extras do usuário.
-- ---------------------------------------------------------------------
create table if not exists public.perfis (
  id         uuid primary key references auth.users (id) on delete cascade,
  nome       text not null,
  email      text not null unique,
  telefone   text,
  criado_em  timestamptz not null default now()
);

comment on table  public.perfis        is 'Dados de perfil de cada usuário cadastrado.';
comment on column public.perfis.id     is 'Mesmo id do usuário em auth.users.';

-- ---------------------------------------------------------------------
-- 2) SEGURANÇA (RLS): cada usuário só enxerga e edita o próprio perfil
-- Sem isso, qualquer visitante com a chave pública leria todos os dados.
-- ---------------------------------------------------------------------
alter table public.perfis enable row level security;

drop policy if exists "perfil: ler o próprio"   on public.perfis;
drop policy if exists "perfil: editar o próprio" on public.perfis;

create policy "perfil: ler o próprio"
  on public.perfis for select
  to authenticated
  using (auth.uid() = id);

create policy "perfil: editar o próprio"
  on public.perfis for update
  to authenticated
  using (auth.uid() = id)
  with check (auth.uid() = id);

-- Não há policy de INSERT/DELETE de propósito:
-- o perfil é criado pelo gatilho abaixo e apagado junto com o usuário.

-- ---------------------------------------------------------------------
-- 3) GATILHO: cria o perfil automaticamente quando alguém se cadastra
-- O nome vem do campo "nome" enviado no cadastro (options.data.nome).
-- ---------------------------------------------------------------------
create or replace function public.criar_perfil_ao_cadastrar()
returns trigger
language plpgsql
security definer
set search_path = ''
as $$
begin
  insert into public.perfis (id, nome, email, telefone)
  values (
    new.id,
    coalesce(nullif(new.raw_user_meta_data ->> 'nome', ''), split_part(new.email, '@', 1)),
    new.email,
    new.raw_user_meta_data ->> 'telefone'
  );
  return new;
end;
$$;

drop trigger if exists ao_cadastrar_usuario on auth.users;

create trigger ao_cadastrar_usuario
  after insert on auth.users
  for each row execute function public.criar_perfil_ao_cadastrar();

-- ---------------------------------------------------------------------
-- 4) CONSULTAS DE CONFERÊNCIA (rode depois de criar o usuário de teste)
-- ---------------------------------------------------------------------
-- select id, nome, email, criado_em from public.perfis;
-- select id, email, email_confirmed_at from auth.users;
