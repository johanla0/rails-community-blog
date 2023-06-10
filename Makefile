BRANCH := $(shell git rev-parse --abbrev-ref HEAD)

assets:
	bin/rails assets:precompile
branch:
	git checkout $(ARGS) > /dev/null 2>&1 || git checkout -b $(ARGS)
c:
	bin/rails console -- --noautocomplete
install:
	bundle install
lint:
	rubocop
lint-slim:
	slim-lint app/views/
pull:
	git pull origin $(BRANCH)
push:
	git push origin $(BRANCH)
routes:
	bin/rails routes | grep "$(ARGS)"
s: server
server:
	rails s
test:
	bin/rails test $(ARGS)
uncommit:
	git reset --soft HEAD^
upd:
	git merge master --no-edit
webpack:
	bin/yarn build --watch

.PHONY: test