# Documentação do banco de dados — cadastro e login de teste

## Objetivo

Permitir que uma pessoa se cadastre, entre na página com e-mail e senha e veja seus dados básicos. É uma versão de teste.

## Ferramentas escolhidas

| Função              | Ferramenta                         | Motivo                                                        |
|---------------------|------------------------------------|---------------------------------------------------------------|
| Banco de dados      | Supabase (PostgreSQL)              | Gratuito, já traz cadastro e login prontos e seguros          |
| Página (front-end)  | HTML + JavaScript                  | Simples, sem instalação, fácil de construir juntos            |
| Hospedagem          | Vercel                             | Gratuita e publica a página em poucos minutos                 |

## Dados guardados

### Usuários (gerenciado pelo Supabase)
E-mail e senha ficam em uma área protegida do próprio Supabase. A senha é guardada de forma criptografada e ninguém, nem nós, consegue lê-la.

### Perfis (tabela nossa)

| Campo      | Obrigatório | Descrição                              |
|------------|-------------|----------------------------------------|
| Identificador | sim      | Liga o perfil ao usuário               |
| Nome       | sim         | Informado no cadastro                  |
| E-mail     | sim         | Copiado automaticamente do cadastro    |
| Telefone   | não         | Opcional                               |
| Criado em  | sim         | Data e hora, preenchidas sozinhas      |

## Regras de segurança

- Cada pessoa logada vê e edita apenas o próprio perfil.
- Quem não fez login não vê nenhum dado.
- O perfil é criado automaticamente no momento do cadastro; ninguém o cria manualmente.
- Se o usuário for excluído, o perfil dele é excluído junto.

## Como funciona o fluxo

1. A pessoa preenche nome, e-mail e senha na página.
2. O Supabase cria o usuário e o perfil é gerado automaticamente.
3. No login, a pessoa informa e-mail e senha.
4. Logada, a página mostra uma saudação com o nome dela.
5. Ao clicar em sair, a sessão é encerrada.

## Passo a passo para colocar no ar

1. Criar conta no Supabase e um projeto novo. Guardar a senha do banco em local seguro.
2. Abrir o editor de SQL do projeto, colar o conteúdo do arquivo do banco e executar.
3. Em Authentication, na opção de e-mail, desligar a confirmação de e-mail apenas para o teste de hoje.
4. Em Project Settings, na área de API, copiar o endereço do projeto e a chave pública (anon).
5. Construir a página de cadastro e login (próxima etapa, juntos).
6. Cadastrar um usuário de teste pela própria página.
7. Conferir no Supabase se o usuário e o perfil apareceram.
8. Publicar na Vercel.

## Pontos de atenção

- A chave de serviço (service_role) e a senha do banco nunca devem ir para a página nem ser compartilhadas.
- Confirmação de e-mail desligada é só para teste; ligar antes de usar com pessoas reais.
- O plano gratuito do Supabase pausa o projeto após cerca de 1 semana sem uso. Serve para teste, não para o site de um cliente.
- Antes de coletar dados de pessoas reais, a página precisa de aviso de privacidade e consentimento (LGPD).

## Próximas etapas

1. Página de cadastro e login.
2. Área do usuário com o nome e botão de sair.
3. Publicação na Vercel.
