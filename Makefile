.SUFFIXES: .txt .html .body

MEDIA != ls media/*
NOTES = \
	202206birds \
	202206clipboard \
	server202204 \
	X11-202204 \
	make
NOTES_TXTS   = ${NOTES:=.txt}
NOTES_BODIES = ${NOTES:=.body}
NOTES_HTMLS  = ${NOTES:=.html}

WWW = www/style.css www/feed.xml www/index.html ${MEDIA:%=www/%} ${NOTES_HTMLS:%.html=www/%.html}

all: index.html feed.xml ${NOTES_HTMLS}

.body.html: template.m4
	m4 -DFILE="${<:.body=}" template.m4 >$@

.txt.body:
	i2html <$< | sed '2s,<p>,&<a href="https://seninha.org">seninha.org</a><br/>,' >$@

index.txt: index.m4 ${NOTES_HTMLS}
	m4 -DNOTES="${NOTES}" index.m4 >$@

feed.xml: feed.m4 ${NOTES_TXTS}
	m4 -DNOTES="${NOTES}" feed.m4 >$@

.for file in style.css feed.xml index.html ${NOTES_HTMLS} ${MEDIA}
www/${file}: ${file}
	install -D -m 644 ${file} www/${file}
.endfor

local: ${WWW}

test: local
	openrsync --rsync-path=openrsync -rtv --del www/ /var/www/seninha.org

deploy: local
	openrsync --rsync-path=openrsync -rtv --del www/ www:/var/www/seninha.org

clean:
	rm -f index.txt index.body index.html feed.xml ${NOTES_BODIES} ${NOTES_HTMLS}

clean-www:
	rm -rf www

.PHONY: all test local deploy clean
