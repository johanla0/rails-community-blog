BRANCH := $(shell git rev-parse --abbrev-ref HEAD)

assets:
	bin/rails assets:precompile
branch:
	git checkout $(ARGS) > /dev/null 2>&1 || git checkout -b $(ARGS)
c:
	bin/rails console -- --noautocomplete
check: lint test
install:
	bundle install
lint: lint-code lint-style
lint-code:
	bundle exec rubocop
	bundle exec slim-lint app/views/
	make lint-eslint
lint-eslint:
	npx eslint app/javascript --ext .js
lint-eslint-fix:
	npx eslint app/javascript --ext .js --fix
lint-style:
	npx stylelint "**/*.scss" "!**/vendor/**"
linter-code-fix:
	bundle exec rubocop -A
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