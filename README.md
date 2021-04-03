# Site de Vagas - ![Badge](https://img.shields.io/static/v1?label=Status&message=Em%20Constru%C3%A7%C3%A3o&color=green&style=flat&logo=STATUS)

## Linguagens, dependências utilizadas

![Badge](https://img.shields.io/static/v1?label=ruby&message=3.0.0&color=red&style=for-the-badge&logo=RUBY)
![Badge](https://img.shields.io/static/v1?label=rails&message=6.1.1&color=red&style=for-the-badge&logo=ruby-on-rails)
![Badge](https://img.shields.io/static/v1?label=rspec-rails&message=4.0.2&color=red&style=for-the-badge)
![Badge](https://img.shields.io/static/v1?label=devise&message=gem&color=red&style=for-the-badge)
![Badge](https://img.shields.io/static/v1?label=capybara&message=gem&color=red&style=for-the-badge)
![Badge](https://img.shields.io/static/v1?label=shoulda-matchers&message=gem&color=red&style=for-the-badge)

## Descrição
Esse projeto (Desenvolvido durante o programa TreinaDev) consiste na criação de uma plataforma Web para que pessoas dos departamentos de RH de empresas criem vagas e sejam capazes de gerenciar todo o processo. Além disso, a plataforma funciona como um site de busca de oportunidades para os visitantes.

## Funcionalidades

- Colaborador
  - pode cria uma conta no sistema
  - pode editar dados da empresa
  - pode anunciar uma vaga
  - pode visualizar as candidaturas recebidas
  - pode fazer uma proposta para o candidato
- Candidato
  - pode visualizar as vagas cadastradas
  - pode criar uma conta no sistema
  - pode editar seus dados
  - pode se candidatar para uma vaga
  - pode visualizar suas candidaturas

## Configuração

1. Copie o projeto para sua máquina

`git clone https://github.com/murilo-miranda/site-vagas.git`

2. Acesse a pasta do projeto

`cd site-vagas.git`

3. Instale as dependências

`bin/setup`

4. Inicie a aplicação

`rails server`

5. Acesse o sistema http://localhost:3000/ utilizando um dos dados abaixo ou então crie um novo usuário:

|               |       nome       |  senha |
| ------------- | ---------------- |--------|
| Empresa Muzak | murilo@muzak.com | 123456 |
| Empresa Kaiba | seto@kaiba.com   | 123456 |
| Usuário comum | murilo@gmail.com | 123456 |