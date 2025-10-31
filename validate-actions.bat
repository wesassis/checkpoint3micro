@echo off
echo ===============================================
echo    VALIDACAO GITHUB ACTIONS - CHECKPOINT 3
echo ===============================================
echo.

echo 1. VERIFICANDO REPOSITORIO GITHUB...
echo Acesse: https://github.com/wesassis/checkpoint3micro
echo.

echo 2. VERIFICANDO GITHUB ACTIONS...
echo Acesse: https://github.com/wesassis/checkpoint3micro/actions
echo.

echo Status esperado das Actions:
echo [✓] Continuous Integration (CI)
echo [✓] Continuous Delivery - Integration Tests  
echo [✓] Continuous Delivery - Docker Hub
echo [✓] Release and Tag Generation
echo.

echo 3. VERIFICANDO DOCKER HUB...
echo Acesse: https://hub.docker.com/r/wesassis/checkpoint3micro
echo Deve aparecer imagem 'latest' apos push
echo.

echo 4. VERIFICANDO RELEASES...
echo Acesse: https://github.com/wesassis/checkpoint3micro/releases
echo Deve aparecer 'Release v1.0.0' apos push na main
echo.

echo ===============================================
echo           COMANDOS DE TESTE LOCAL
echo ===============================================
echo.

echo Testando compilacao local...
mvn clean compile
if %errorlevel% equ 0 (
    echo [✓] Compilacao OK
) else (
    echo [✗] Erro na compilacao
    goto :error
)
echo.

echo Testando testes de integracao...
mvn test -Dtest=*IntegrationTest
if %errorlevel% equ 0 (
    echo [✓] Testes de integracao OK
) else (
    echo [✗] Erro nos testes de integracao
    goto :error
)
echo.

echo Testando build completo...
mvn clean package -DskipTests
if %errorlevel% equ 0 (
    echo [✓] Build completo OK
) else (
    echo [✗] Erro no build
    goto :error
)
echo.

echo ===============================================
echo              CHECKLIST FINAL
echo ===============================================
echo.
echo [ ] Docker Hub repositorio 'checkpoint3micro' criado
echo [ ] Access Token gerado no Docker Hub
echo [ ] GitHub Secrets configurados (DOCKER_USERNAME, DOCKER_PASSWORD)
echo [ ] Push feito para branch main
echo [ ] 4 GitHub Actions executando sem erro
echo [ ] Imagem disponivel no Docker Hub
echo [ ] Release gerado no GitHub
echo.

echo ===============================================
echo                 RESULTADO
echo ===============================================
echo [✓] Validacao local concluida com sucesso!
echo.
echo Proximos passos:
echo 1. Verificar GitHub Actions em: https://github.com/wesassis/checkpoint3micro/actions
echo 2. Verificar Docker Hub em: https://hub.docker.com/r/wesassis/checkpoint3micro
echo 3. Entregar arquivo ENTREGA.txt no Portal do Aluno
echo.
goto :end

:error
echo.
echo [✗] Erro encontrado! Verifique os logs acima.
echo.

:end
pause
