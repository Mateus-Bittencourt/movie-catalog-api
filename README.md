# MOVIE CATALOG API

 > API que recebe arquivos do tipo csv com listas de filmes e importa para o banco de dados para consultas.

* Ruby version
  3.1.2

* Rails version
  7.0.4

* PostgreSQL version
  12

## Como instalar

* Clone este repositório e instale as dependências com o seguinte comando:
```
bundle install
```

## Para criar e inicializar o banco de dados

* Execute o comando abaixo no seu terminal dentro da pasta do projeto:
```
rails db:create db:migrate
```

## Execute a aplicação

```
rails s
```

## Como usar a API

* Para importar o arquivo csv para o banco de dados, envie um POST request para o endpoint abaixo seguindo o padrão:
 > headers => Content-Type  text/csv
 > body => file: csv_file.csv
```
http://localhost:3000/movies
```

* Para listar todos os filmes cadastrados basta fazer um GET request no mesmo endereço:
```
http://localhost:3000/movies
```

* Também é possivel filtrar utilizando uma palavra-chave que realizará uma busca em todos os campos(title, genre, year, country, published_at e description)
```
http://localhost:3000/movies/<palavra-chave>
```

## TESTES

* Para rodar a suite de testes execute o comando abaixo:
```
rspec
```
