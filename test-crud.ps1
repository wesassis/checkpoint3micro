# Script de Teste CRUD - Products API
# Execute este script para testar todos os endpoints

Write-Host "=== TESTANDO API PRODUCTS CRUD ===" -ForegroundColor Green

# Aguardar aplicação inicializar
Write-Host "Aguardando aplicação inicializar..." -ForegroundColor Yellow
Start-Sleep -Seconds 5

# Teste 1: Listar todos os produtos (deve retornar os dados iniciais)
Write-Host "`n1. TESTANDO GET /api/products (Listar todos)" -ForegroundColor Cyan
try {
    $response1 = Invoke-RestMethod -Uri "http://localhost:8080/api/products" -Method GET
    Write-Host "✅ Sucesso! Produtos encontrados:" ($response1.Length) -ForegroundColor Green
    $response1 | ForEach-Object { Write-Host "   - $($_.name) - R$ $($_.price)" }
} catch {
    Write-Host "❌ Erro ao listar produtos: $($_.Exception.Message)" -ForegroundColor Red
}

# Teste 2: Criar um novo produto
Write-Host "`n2. TESTANDO POST /api/products (Criar produto)" -ForegroundColor Cyan
$newProduct = @{
    name = "Produto Teste CRUD"
    description = "Produto criado via script de teste"
    price = 199.99
    quantity = 5
} | ConvertTo-Json

try {
    $response2 = Invoke-RestMethod -Uri "http://localhost:8080/api/products" -Method POST -Body $newProduct -ContentType "application/json"
    $createdId = $response2.id
    Write-Host "✅ Produto criado com sucesso! ID: $createdId" -ForegroundColor Green
    Write-Host "   Nome: $($response2.name)" 
    Write-Host "   Preço: R$ $($response2.price)"
} catch {
    Write-Host "❌ Erro ao criar produto: $($_.Exception.Message)" -ForegroundColor Red
    return
}

# Teste 3: Buscar produto por ID
Write-Host "`n3. TESTANDO GET /api/products/{id} (Buscar por ID)" -ForegroundColor Cyan
try {
    $response3 = Invoke-RestMethod -Uri "http://localhost:8080/api/products/$createdId" -Method GET
    Write-Host "✅ Produto encontrado por ID!" -ForegroundColor Green
    Write-Host "   ID: $($response3.id) - Nome: $($response3.name)"
} catch {
    Write-Host "❌ Erro ao buscar produto por ID: $($_.Exception.Message)" -ForegroundColor Red
}

# Teste 4: Atualizar produto
Write-Host "`n4. TESTANDO PUT /api/products/{id} (Atualizar produto)" -ForegroundColor Cyan
$updateProduct = @{
    name = "Produto Teste CRUD - ATUALIZADO"
    description = "Produto atualizado via script de teste"
    price = 299.99
    quantity = 10
} | ConvertTo-Json

try {
    $response4 = Invoke-RestMethod -Uri "http://localhost:8080/api/products/$createdId" -Method PUT -Body $updateProduct -ContentType "application/json"
    Write-Host "✅ Produto atualizado com sucesso!" -ForegroundColor Green
    Write-Host "   Nome: $($response4.name)"
    Write-Host "   Novo Preço: R$ $($response4.price)"
} catch {
    Write-Host "❌ Erro ao atualizar produto: $($_.Exception.Message)" -ForegroundColor Red
}

# Teste 5: Buscar produtos por nome
Write-Host "`n5. TESTANDO GET /api/products/search?name=... (Buscar por nome)" -ForegroundColor Cyan
try {
    $response5 = Invoke-RestMethod -Uri "http://localhost:8080/api/products/search?name=CRUD" -Method GET
    Write-Host "✅ Busca por nome realizada! Produtos encontrados:" ($response5.Length) -ForegroundColor Green
    $response5 | ForEach-Object { Write-Host "   - $($_.name)" }
} catch {
    Write-Host "❌ Erro ao buscar por nome: $($_.Exception.Message)" -ForegroundColor Red
}

# Teste 6: Deletar produto
Write-Host "`n6. TESTANDO DELETE /api/products/{id} (Deletar produto)" -ForegroundColor Cyan
try {
    Invoke-RestMethod -Uri "http://localhost:8080/api/products/$createdId" -Method DELETE
    Write-Host "✅ Produto deletado com sucesso!" -ForegroundColor Green
} catch {
    Write-Host "❌ Erro ao deletar produto: $($_.Exception.Message)" -ForegroundColor Red
}

# Teste 7: Verificar se produto foi realmente deletado
Write-Host "`n7. VERIFICANDO se produto foi deletado" -ForegroundColor Cyan
try {
    $response7 = Invoke-RestMethod -Uri "http://localhost:8080/api/products/$createdId" -Method GET
    Write-Host "❌ Produto ainda existe! Erro na deleção." -ForegroundColor Red
} catch {
    if ($_.Exception.Response.StatusCode -eq 404) {
        Write-Host "✅ Produto foi deletado corretamente (404 Not Found)!" -ForegroundColor Green
    } else {
        Write-Host "❌ Erro inesperado: $($_.Exception.Message)" -ForegroundColor Red
    }
}

# Teste 8: Listar produtos finais
Write-Host "`n8. LISTAGEM FINAL de produtos" -ForegroundColor Cyan
try {
    $responseFinal = Invoke-RestMethod -Uri "http://localhost:8080/api/products" -Method GET
    Write-Host "✅ Lista final de produtos:" ($responseFinal.Length) -ForegroundColor Green
    $responseFinal | ForEach-Object { 
        Write-Host "   - ID: $($_.id) | $($_.name) | R$ $($_.price) | Qtd: $($_.quantity)" 
    }
} catch {
    Write-Host "❌ Erro ao listar produtos finais: $($_.Exception.Message)" -ForegroundColor Red
}

Write-Host "`n=== TESTE CRUD FINALIZADO ===" -ForegroundColor Green
Write-Host "Acesse http://localhost:8080/swagger-ui.html para testes visuais" -ForegroundColor Yellow
