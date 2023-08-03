<h1 align="center"> Terraform - AWS - Desafio Infra Pleno 2</h1>

Execução da aplicação `desafio-infra-pleno` em ambiente AWS<br>
Provisionamento de ambiente de rede e computação através do Terraform<br>
O ambiente pode ser provisionado utilizando uma conta AWS de nível gratuito. Nenhum recurso utilizado arremente a cobranças utilizando o nível gratuito.

Neste projeto são provisionados recursos como:
  - Instância EC2
  - VPC
    - Sub redes
    - Tabela de roteamento
    - Gateway de Internet
    - Grupos de segurança

 # :hammer: Requisitos
 - Acessar a AWS
   - Crie um usuário no Identity ans Access Management (IAM)
     - Com politicas para criação de instâncias e recursos EC2 e criação de componentes e recursos VPC 
     - Configure uma chave de acesso para utilizar o Command Line Interface (CLI)
  - AWS CLI:
      https://docs.aws.amazon.com/cli/index.html
  - Terraform:
      https://developer.hashicorp.com/terraform/downloads
    
  # :arrow_forward: Executando o projeto
  - Realizar um clone deste repositório
    ```cmd
    git clone https://github.com/carloshvsilva/desafio-infra-pleno-2.git
    ```
  - Acessar a rais do repositório onde contém o arquivo `main.tf` e executar:
    - Inicialia diretório de trabalho contendo arquivos de configuração do Terraform
      ```cmd
      terraform init
      ```
    - Para criar o plano de execução
      ```cmd
      terraform apply
      ```
    - Para aceitar a criação/alteração dos elementos a ser provisionados
      ```cmd
      yes
      ```
    - Ao final da execução será informado o IP publico da instância EC2. Aguarde em torno de 5 minutos para todo o ambiente ser provisionado e para que todos programas necessários sejam instalados
      
    - Insira em seu navegador o IP público da instância para ver sua aplicação rodando
      
    - Para eliminar todos os componetes criados, execute:
      ```cmd
      terraform destroy
      ```
    
 # :wrench: Descrição dos arquivos
 - `main.tf`: contém as informações para o provisionamento da infraestrutura de rede e computação
 - `scripts\ubuntu.sh`
   
