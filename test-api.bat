@echo off
echo === TESTE BASICO DA API ===
echo.

echo Verificando se a aplicacao esta rodando...
curl -s -o nul -w "%%{http_code}" http://localhost:8080/actuator/health > temp_status.txt
set /p STATUS=<temp_status.txt
del temp_status.txt

if "%STATUS%"=="200" (
    echo ✅ Aplicacao esta rodando!
    echo.
    
    echo Testando GET /api/products...
    curl -X GET http://localhost:8080/api/products
    echo.
    echo.
    
    echo Testando POST /api/products...
    curl -X POST http://localhost:8080/api/products ^
         -H "Content-Type: application/json" ^
         -d "{\"name\":\"Produto Teste\",\"description\":\"Teste\",\"price\":99.99,\"quantity\":5}"
    echo.
    echo.
    
    echo Acesse http://localhost:8080/swagger-ui.html para testes completos
) else (
    echo ❌ Aplicacao nao esta rodando na porta 8080
    echo Verifique se a aplicacao foi iniciada corretamente
)

pause
