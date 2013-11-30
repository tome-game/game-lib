
all:
	@./node_modules/.bin/grunt

clean:
	@./node_modules/.bin/grunt clean

test:
	@./node_modules/.bin/grunt mochaTest

.PHONY: test