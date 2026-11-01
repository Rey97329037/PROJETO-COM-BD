# Cadastro e login com Supabase

Página simples de cadastro e login ligada a um banco de dados PostgreSQL.

## O que faz

- Cadastro com nome, e-mail e senha
- Login e logout
- Área do usuário com nome, e-mail e data de cadastro

## Tecnologias

- Supabase (PostgreSQL + autenticação)
- HTML, CSS e JavaScript, sem framework

## Estrutura

```
projeto/
  index.html        página com cadastro, login e área do usuário
  banco.sql         tabela, regras de segurança e gatilho
  DOCUMENTACAO.md   documentação do banco de dados
```

## Banco de dados

- Tabela `perfis`, ligada aos usuários do Supabase (`auth.users`).
- Segurança por linha (RLS): cada usuário lê e edita apenas o próprio perfil.
- Gatilho que cria o perfil no momento do cadastro.

Detalhes em [`projeto/DOCUMENTACAO.md`](projeto/DOCUMENTACAO.md).

## Como executar

1. Crie um projeto no [Supabase](https://supabase.com).
2. No **SQL Editor**, execute o conteúdo de `projeto/banco.sql`.
3. Em **Authentication > Providers > Email**, ajuste a confirmação de e-mail (desligue apenas para testes).
4. Em `projeto/index.html`, informe a **Project URL** e a chave **publishable** nas constantes `SUPABASE_URL` e `SUPABASE_KEY`.
5. Abra `projeto/index.html` no navegador.

## Segurança

- Apenas a chave pública (publishable) fica no front-end.
- Nunca publique a chave `service_role`/`secret` nem a senha do banco.
- O acesso aos dados é controlado pelas regras de RLS do banco.

## Próximos passos

- Publicar online
- Ajustar as mensagens da tela de login
- Revisar a criação do perfil para contas criadas antes do gatilho
- Ativar a confirmação de e-mail e configurar o Site URL
