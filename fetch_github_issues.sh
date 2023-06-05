for i in {1..50}; do curl "https://github.com/search?q=language%3AJulia+nan+NaN+NAN++&type=issues&s=created&o=desc&state=open&p=$i" --output "page_$i.html"; sleep 10; done
