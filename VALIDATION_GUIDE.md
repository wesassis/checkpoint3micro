# 🔍 GUIA DE VALIDAÇÃO - GITHUB ACTIONS

## 📋 **CONFIGURAÇÃO OBRIGATÓRIA**

### **PASSO 1: Docker Hub (OBRIGATÓRIO)**
1. **Repositório criado:** https://hub.docker.com/r/wesassis/checkpoint3micro
2. **Access Token gerado** com permissões `Read, Write, Delete`

### **PASSO 2: GitHub Secrets (OBRIGATÓRIO)**
Verifique em: https://github.com/wesassis/checkpoint3micro/settings/secrets/actions

Secrets necessários:
- ✅ `DOCKER_USERNAME` = `wesassis`
- ✅ `DOCKER_PASSWORD` = `[seu_token_docker_hub]`

## 🧪 **VALIDAÇÃO LOCAL**

Execute o script de validação:
```cmd
cd "d:\CP3 - MICRO"
validate-actions.bat
```

### **Testes que devem passar:**
- ✅ `mvn clean compile` - Compilação
- ✅ `mvn test -Dtest=*IntegrationTest` - Testes integração
- ✅ `mvn clean package -DskipTests` - Build completo

## 🚀 **VALIDAÇÃO NO GITHUB**

### **1. Verificar Actions Executando**
**URL:** https://github.com/wesassis/checkpoint3micro/actions

**Status esperado após push:**
- ✅ **CI** (Continuous Integration) - Verde
- ✅ **CD Integration Tests** - Verde  
- ✅ **CD Docker Hub** - Verde
- ✅ **Release** - Verde (apenas na branch main)

### **2. Verificar Workflows Individuais**

#### **CI (ci.yml)**
- Trigger: push em `develop`, `feature/*`, `hotfix/*`
- Função: Testes unitários + Build Maven
- **Deve passar:** Sempre (testes simples)

#### **CD Integration Tests (cd-integration-tests.yml)**
- Trigger: push em `develop`, `main`
- Função: Testes de integração CRUD
- **Deve passar:** Se testes passam localmente

#### **CD Docker Hub (cd-docker-hub.yml)**
- Trigger: push em `develop`, `main`
- Função: Build e push imagem Docker
- **Deve passar:** Se secrets configurados

#### **Release (release.yml)**
- Trigger: push em `main`
- Função: Gerar tag e release
- **Deve passar:** Se na branch main

## 🐳 **VALIDAÇÃO DOCKER HUB**

### **Verificar Imagem Publicada**
**URL:** https://hub.docker.com/r/wesassis/checkpoint3micro

**O que deve aparecer:**
- ✅ Imagem `latest`
- ✅ Tags com branch names (ex: `main`, `develop`)
- ✅ Última atualização recente

### **Testar Imagem Localmente**
```cmd
# Baixar e testar imagem
docker pull wesassis/checkpoint3micro:latest
docker run -p 8080:8080 wesassis/checkpoint3micro:latest

# Testar endpoints
curl http://localhost:8080/api/products
```

## 📦 **VALIDAÇÃO RELEASES**

### **Verificar Release Gerado**
**URL:** https://github.com/wesassis/checkpoint3micro/releases

**O que deve aparecer:**
- ✅ `Release v1.0.0`
- ✅ Arquivo JAR anexado
- ✅ Changelog com descrição

## 🔧 **SOLUÇÃO DE PROBLEMAS**

### **Se CI falhar:**
```cmd
# Testar localmente
mvn clean compile test
```
- Verificar logs de compilação
- Corrigir erros Java/Maven

### **Se Integration Tests falhar:**
```cmd
# Testar localmente
mvn test -Dtest=*IntegrationTest
```
- Verificar se 8/8 testes passam
- Corrigir falhas nos testes

### **Se Docker Hub falhar:**
- ✅ Verificar secrets `DOCKER_USERNAME` e `DOCKER_PASSWORD`
- ✅ Verificar se repositório Docker Hub existe
- ✅ Verificar permissões do token

### **Se Release falhar:**
- ✅ Verificar se push foi na branch `main`
- ✅ Verificar se `pom.xml` tem versão válida
- ✅ Verificar logs da Action

## ✅ **CHECKLIST COMPLETO**

### **Configuração:**
- [ ] Docker Hub repositório criado
- [ ] Access Token gerado
- [ ] GitHub Secrets configurados
- [ ] Arquivo duplicado removido

### **Validação Local:**
- [ ] `validate-actions.bat` executado
- [ ] Compilação OK
- [ ] Testes integração OK
- [ ] Build OK

### **Validação GitHub:**
- [ ] 4 Actions executando
- [ ] Todas com status verde
- [ ] Imagem no Docker Hub
- [ ] Release gerado

### **Entrega:**
- [ ] `ENTREGA.txt` atualizado
- [ ] URLs corretas no arquivo
- [ ] Enviado no Portal do Aluno

## 🎯 **RESULTADO FINAL**

**Com todas as validações OK:**
- ✅ **Checkpoint 3** - 10/10 pontos
- ✅ **CI/CD completo** funcionando
- ✅ **Imagem Docker** publicada
- ✅ **Pronto para entrega**

---

**🚀 Execute o script de validação e verifique cada item!**
