After `git clone`, `git submodule update --init --recursive` to get all submodules.

1. Setup docker engine with compose or docker desktop;
2. Install VSCode with extension "Dev Containers";
3. Execute "docker compose up". It's gonna take a while;
4. Once up, PgAdmin is accessible through "localhost:5050";
5. Migrate postgres db with "flyway-migrate" script in "./database";
   1. For now this directory is outside devcontainers;
   2. On linux run "./flyway-migrate.sh";
   3. On windows run "flyway-migrate.bat";
7. Select "Open workspace in container" action and then the local dev_env.code-workspace file;
8. In the backend folder, execute "go run ./cmd/server";
9. In the website folder, execute "yarn install & yarn run dev";
8. If backend+website started successfully, proglv is on localhost;

Tip: use Ctrl+r shortcut for faster movement across vscode dir history.