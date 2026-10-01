@echo off
REM =======================================================================
REM Script Batch de Publicação no GitHub - Indústria & Produção
REM Repositório: https://github.com/bibianodenis-dev/Industria-Producao.git
REM =======================================================================

echo [INFO] Configurando conexao remota com o GitHub...

git remote remove origin 2>nul
git remote add origin https://github.com/bibianodenis-dev/Industria-Producao.git
git branch -M main

echo [INFO] Remote configurado com sucesso:
git remote -v

echo.
echo [INFO] Enviando alteracoes para origin/main...
git push -u origin main

if %ERRORLEVEL% EQU 0 (
    echo.
    echo [SUCESSO] Projeto publicado no GitHub com sucesso!
) else (
    echo.
    echo [ERRO] Falha no push. Verifique suas credenciais do GitHub.
)
pause
