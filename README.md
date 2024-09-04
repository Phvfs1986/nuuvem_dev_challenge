
# Nuuvem Dev Test

## Este é um aplicativo desenvolvido em Ruby on Rails com Tailwind CSS e Redis.
## Abaixo estão as instruções para configurar e executar o projeto localmente.

## Requisitos

- Ruby 3.1 ou superior
- Rails 7 ou superior
- Docker (para Redis)

## Configuração

1.  **Descompacte o arquivo ZIP:**  
    Extraia o conteúdo do arquivo ZIP para o diretório de sua escolha. O
    aplicativo estará na pasta `nuuvem_dev_challenge`.

2.  **Instale as dependências do Ruby:**  
    Navegue até o diretório do projeto e execute:

        bundle install

3.  **Configure o Redis:**  
    O Redis é executado em um container Docker. Primeiro, puxe a imagem
    oficial do Redis:

        docker pull redis

    Em seguida, execute o container usando o seguinte comando:

        docker run -d -p 6379:6379 redis

    **Explicação do comando:**

    - **`docker run -d`**: Executa o container em segundo plano.
    - **`-p 6379:6379`**: Mapeia a porta 6379 do seu host para a porta
      6379 do container, permitindo que você se conecte ao Redis na
      porta padrão.
    - **`redis`**: Tag da imagem Docker oficial do Redis. O Docker
      buscará a imagem mais recente disponível com essa tag.

    **Encontrar o Nome da Imagem Docker Localmente:**

    Para verificar se a imagem do Redis está disponível localmente e
    encontrar seu nome ou ID, use:

        docker images

    Procure por `redis` na lista de imagens. O nome da imagem será
    geralmente `redis`, e o ID da imagem será mostrado na coluna
    `IMAGE ID`.

4.  **Configure o banco de dados:**  
    Crie e migre o banco de dados com os seguintes comandos:

        bin/rails db:create
        bin/rails db:migrate

5.  **Execute o servidor com Tailwind CSS:**  
    Use o comando `bin/dev` para iniciar o servidor com o Tailwind CSS:

        bin/dev

## Testes

Para executar os testes, use o comando:

    bundle exec rspec

Os arquivos de exemplo para testes de upload estão localizados na pasta
`example files`. Os relatórios de cobertura de testes estão na pasta
`test coverage report`.

## Desenvolvedor

Paulo Verissimo F. de Souza