# MightyFitness_backend

Sistema backend para a plataforma Mighty Fitness, desenvolvido em Laravel.

## Índice

- [Sobre o Projeto](#sobre-o-projeto)
- [Tecnologias](#tecnologias)
- [Requisitos](#requisitos)
- [Instalação](#instalação)
- [Configuração](#configuração)
- [Como Usar](#como-usar)
- [Testes](#testes)
- [Contribuição](#contribuição)
- [Licença](#licença)

## Sobre o Projeto

Este projeto fornece a API e o painel administrativo para o aplicativo Mighty Fitness, permitindo o gerenciamento de usuários, treinos, dietas, permissões, notificações e integrações com serviços externos.

## Tecnologias

- PHP ^8.2
- Laravel ^11.9
- MySQL
- [spatie/laravel-permission](https://github.com/spatie/laravel-permission)
- [spatie/laravel-medialibrary](https://github.com/spatie/laravel-medialibrary)
- [yajra/laravel-datatables](https://github.com/yajra/laravel-datatables)
- [maatwebsite/excel](https://github.com/Maatwebsite/Laravel-Excel)
- [laravel-notification-channels/onesignal](https://github.com/laravel-notification-channels/onesignal)
- Bootstrap 5, jQuery, ApexCharts, entre outros (frontend admin)

## Requisitos

- PHP 8.2 ou superior
- Composer
- Node.js e npm
- MySQL

## Instalação

1. Clone o repositório:
   ```sh
   git clone https://gitlab.com/mobile-app23/fitness-app/mightyfitness_backend.git
   cd mightyfitness_backend
   ```

2. Instale as dependências PHP:
   ```sh
   composer install
   ```

3. Instale as dependências JS:
   ```sh
   npm install
   ```

4. Compile os assets:
   ```sh
   npm run dev
   ```

## Configuração

1. Copie o arquivo de exemplo de ambiente:
   ```sh
   cp .env.example .env
   ```

2. Configure as variáveis do `.env` conforme seu ambiente (banco de dados, e-mail, etc).

3. Gere a chave da aplicação:
   ```sh
   php artisan key:generate
   ```

4. Execute as migrações e (opcional) seeders:
   ```sh
   php artisan migrate
   php artisan db:seed
   ```

## Como Usar

- Inicie o servidor local:
  ```sh
  php artisan serve
  ```
- Acesse o painel em [http://127.0.0.1:8000](http://127.0.0.1:8000)

## Testes

Para rodar os testes automatizados:
```sh
php artisan test
```

## Contribuição

Contribuições são bem-vindas! Siga os passos abaixo:

1. Fork este repositório
2. Crie uma branch (`git checkout -b feature/nome-da-feature`)
3. Commit suas alterações (`git commit -am 'Adiciona nova feature'`)
4. Push para a branch (`git push origin feature/nome-da-feature`)
5. Abra um Pull Request

## Licença

Este projeto está licenciado sob a licença MIT.

---

## Extras

Este repositório também inclui um projeto Flutter localizado em:

```
Feature_plataforma_fitness01/assets/
```

Esse aplicativo mobile está conectado ao backend MightyFitness e possui as seguintes funcionalidades:

- 📱 App de treino e dieta com interface moderna
- 🎮 Módulo de jogo e gamificação
- 💬 Chatbot integrado
- 🎥 Player de vídeos (YouTube e local)
- 📊 Monitoramento de progresso do usuário
- 🌐 Suporte multilíngue e tema personalizado
