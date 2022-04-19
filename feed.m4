changequote(`{', `}')dnl
define({PRINT_ITEM}, {<item>
<title>esyscmd(sed 's/^ *//;1q' "$1.txt" | tr -d '\n')</title>
<link>https://seninha.org/$1.html</link>
<guid isPermaLink="true">https://seninha.org/$1.html</guid>
<pubDate>esyscmd(sed '2s/^ *//; 2!d' "$1.txt" | xargs date -jf {"%Y-%m-%d" "+%a, %d %b %Y 00:00:00 -0300"} | tr -d '\n')</pubDate>
<description>esyscmd(awk {'n==2{exit}NF&&n{print};!NF{n++}'} "$1.txt" | {sed 's/&/\&amp;/g; s/</\&lt;/g; s/>/\&gt;/g; s/"/\&quot;/g; s/'"'"'/\&#39;/g'})</description>
</item>
})dnl
<?xml version="1.0" encoding="UTF-8"?>
<rss version="2.0" xmlns:atom="http://www.w3.org/2005/Atom">
	<channel>
		<title>seninha.org</title>
		<description>Seninha's notes</description>
		<link>https://seninha.org/</link>
		<atom:link href="https://seninha.org/feed.xml" rel="self" type="application/rss+xml"/>
PRINT_ITEM(patsubst(NOTES, { +}, {)PRINT_ITEM(}))dnl
	</channel>
</rss>
