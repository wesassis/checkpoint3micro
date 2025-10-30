# Products API - SOA Checkpoint 3

Uma API REST completa para gerenciamento de produtos desenvolvida com Spring Boot para a disciplina de SOA - Microservices and Web Engineering.

## 🚀 Tecnologias

- **Java 17**
- **Spring Boot 3.1.5**
- **Spring Data JPA**
- **Maven**
- **H2 Database** (desenvolvimento)
- **PostgreSQL** (produção/Docker)
- **Docker & Docker Compose**
- **Swagger/OpenAPI 3**
- **JUnit 5** (testes)
- **GitHub Actions** (CI/CD)

## 📋 Funcionalidades

### CRUD Completo de Produtos
- ✅ **CREATE** - Criar novos produtos
- ✅ **READ** - Listar e buscar produtos
- ✅ **UPDATE** - Atualizar produtos existentes
- ✅ **DELETE** - Remover produtos

### Endpoints da API

| Método | Endpoint | Descrição |
|--------|----------|-----------|
| GET | `/api/products` | Lista todos os produtos |
| GET | `/api/products/{id}` | Busca produto por ID |
| POST | `/api/products` | Cria novo produto |
| PUT | `/api/products/{id}` | Atualiza produto |
| DELETE | `/api/products/{id}` | Remove produto |
| GET | `/api/products/search?name={name}` | Busca produtos por nome |
| GET | `/api/products/price-range?minPrice={min}&maxPrice={max}` | Busca por faixa de preço |

## 🛠️ Execução Local

### Pré-requisitos
- Java 17+
- Maven 3.6+
- Docker (opcional)

### 1. Clonando o repositório
```bash
git clone https://github.com/wesassis/checkpoint3micro.git
cd checkpoint3micro
```

### 2. Executando com Maven
```bash
# Compilar e executar testes
mvn clean test

# Compilar aplicação
mvn clean package

# Executar aplicação
mvn spring-boot:run
```

A aplicação estará disponível em: `http://localhost:8080`

### 3. Acessando a documentação
- **Swagger UI**: http://localhost:8080/swagger-ui.html
- **API Docs**: http://localhost:8080/api-docs
- **H2 Console**: http://localhost:8080/h2-console

## 🐳 Execução com Docker

### 1. Executando a partir da imagem do Docker Hub
```bash
docker run -p 8080:8080 wesassis/checkpoint3micro:latest
```

### 2. Executando com docker-compose
```bash
# Subir todos os serviços (API + PostgreSQL)
docker-compose up -d

# Verificar logs
docker-compose logs -f

# Parar serviços
docker-compose down
```

### 3. Build da imagem local
```bash
# Compilar aplicação
mvn clean package

# Build da imagem
docker build -t checkpoint3:local .

# Executar container
docker run -p 8080:8080 checkpoint3:local
```

## 🧪 Testes

### Executar todos os testes
```bash
mvn test
```

### Executar apenas testes de integração
```bash
mvn test -Dtest=*IntegrationTest
```

### Cobertura de testes
```bash
mvn clean test jacoco:report
```

## 🔄 CI/CD Pipeline

### GitHub Actions configuradas:

1. **Continuous Integration** (`ci.yml`)
   - Trigger: push em `develop`, `feature/*`, `hotfix/*`
   - Executa testes unitários
   - Faz build com Maven

2. **Continuous Delivery - Integration Tests** (`cd-integration-tests.yml`)
   - Trigger: push em `develop`, `main`
   - Executa testes de integração completos
   - Testa CRUD completo

3. **Continuous Delivery - Docker Hub** (`cd-docker-hub.yml`)
   - Trigger: push em `develop`, `main`
   - Faz build e push da imagem Docker
   - Publica no Docker Hub

4. **Release Generation** (`release.yml`)
   - Trigger: push em `main`
   - Gera documentação da versão
   - Cria release e tag no GitHub

### Configuração de Secrets no GitHub:
```
DOCKER_USERNAME: seu_usuario_dockerhub
DOCKER_PASSWORD: sua_senha_dockerhub
```

## 📊 Exemplo de Uso da API

### Criar um produto
```bash
curl -X POST http://localhost:8080/api/products \
  -H "Content-Type: application/json" \
  -d '{
    "name": "Notebook Dell",
    "description": "Notebook Dell Inspiron 15",
    "price": 2999.99,
    "quantity": 10
  }'
```

### Listar produtos
```bash
curl -X GET http://localhost:8080/api/products
```

### Buscar produto por ID
```bash
curl -X GET http://localhost:8080/api/products/1
```

### Atualizar produto
```bash
curl -X PUT http://localhost:8080/api/products/1 \
  -H "Content-Type: application/json" \
  -d '{
    "name": "Notebook Dell Atualizado",
    "description": "Notebook Dell Inspiron 15 - Nova versão",
    "price": 3199.99,
    "quantity": 8
  }'
```

### Deletar produto
```bash
curl -X DELETE http://localhost:8080/api/products/1
```

## 🗃️ Modelo de Dados

### Product Entity
```json
{
  "id": 1,
  "name": "Nome do produto",
  "description": "Descrição do produto",
  "price": 99.99,
  "quantity": 10,
  "createdAt": "2025-10-30T10:00:00",
  "updatedAt": "2025-10-30T11:00:00"
}
```

## 🏗️ Arquitetura

```
├── Controller Layer    (REST API endpoints)
├── Service Layer      (Business logic)
├── Repository Layer   (Data access)
├── Entity Layer       (JPA entities)
└── DTO Layer         (Data transfer objects)
```

## 📈 Monitoramento

### Health Check
```bash
curl http://localhost:8080/actuator/health
```

### Métricas
```bash
curl http://localhost:8080/actuator/metrics
```

## 🤝 Contribuição

1. Fork o projeto
2. Crie uma branch para sua feature (`git checkout -b feature/nova-feature`)
3. Commit suas mudanças (`git commit -m 'Adiciona nova feature'`)
4. Push para a branch (`git push origin feature/nova-feature`)
5. Abra um Pull Request

## 📝 Licença

Este projeto foi desenvolvido para fins acadêmicos como parte do Checkpoint 3 da disciplina SOA - Microservices and Web Engineering.

## 👥 Desenvolvido por

- Wesley Assis

---

**Links:**
- GitHub: https://github.com/wesassis/checkpoint3micro
- Docker Hub: https://hub.docker.com/r/wesassis/checkpoint3micro
