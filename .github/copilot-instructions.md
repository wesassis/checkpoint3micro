# Copilot Instructions for Products API

<!-- Use this file to provide workspace-specific custom instructions to Copilot. For more details, visit https://code.visualstudio.com/docs/copilot/copilot-customization#_use-a-githubcopilotinstructionsmd-file -->

This is a Java Spring Boot microservice project for SOA Checkpoint 3. The application provides a complete CRUD REST API for product management.

## Project Structure
- **Entity**: Product with fields id, name, description, price, quantity, createdAt, updatedAt
- **Repository**: JPA repository with custom queries
- **Service**: Business logic layer with CRUD operations
- **Controller**: REST API endpoints with Swagger documentation
- **DTO**: Data Transfer Objects for API requests/responses
- **Exception Handling**: Global exception handler with custom exceptions

## Key Technologies
- Spring Boot 3.1.5
- Java 17
- Maven
- H2 Database (default) / PostgreSQL (Docker)
- Docker & Docker Compose
- GitHub Actions for CI/CD
- Swagger/OpenAPI 3 for documentation
- JUnit 5 for testing

## API Endpoints
- GET /api/products - List all products
- GET /api/products/{id} - Get product by ID
- POST /api/products - Create new product
- PUT /api/products/{id} - Update product
- DELETE /api/products/{id} - Delete product
- GET /api/products/search?name={name} - Search products by name

## Testing
- Integration tests are located in ProductControllerIntegrationTest
- Tests cover all CRUD operations
- Use @Transactional for test isolation

## Docker
- Dockerfile for containerization
- docker-compose.yml with PostgreSQL database
- Multi-profile configuration (default/docker)

## CI/CD Pipeline
- CI: Runs on develop, feature, hotfix branches
- CD Integration Tests: Runs on develop, main branches
- CD Docker Hub: Builds and pushes Docker images
- Release: Creates tags and releases on main branch

When working with this project, follow Spring Boot best practices and maintain the existing code structure and patterns.
