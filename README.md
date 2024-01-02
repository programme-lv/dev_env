After `git clone`, `git submodule update --init --recursive` to get all submodules.

1. Setup docker engine with compose or docker desktop;
2. Install VSCode with extension "Dev Containers";
3. Execute "docker compose up". It's gonna take a while;
4. Once up, PgAdmin is accessible through "localhost:5050";
5. Migrate postgres db with "flyway-migrate" script in "./database";
   1. For now this directory is outside devcontainers;
   2. On linux run "./flyway-migrate.sh";
   3. On windows run "flyway-migrate.bat";
6. To attach to backend (GraphQl golang service):
   1. Select "Reopen in container" action, select "backend";
   2. In backend devcontainer, execute "go run ./cmd/server";
7. To attach to website (Next.js service)
   1. Select "Reopen in container" action, select "website";
   2. In website devcontainer, execute "yarn install" & "yarn run dev";
8. If backend+website started successfully, proglv is on localhost;

Unfortunately, each time after attaching to container, vscode closes folder. To attach to another devcontainer, reopen vscode in this folder again. Use Ctrl+r shortcut for faster movement.