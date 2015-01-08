#!/bin/bash

[ -z "$1" ] && { echo "Usage: $0 <program_name>" ; exit 1; }

readonly PROG="$@"
printf "+-----------------------+-----------------------+---------------+\n"
printf "|\t%10s\t|\t%s\t|\t%s\t|\n" "program name" "Mem (%) :: Size" "CPU (%)"
printf "+-----------------------+-----------------------+---------------+\n"

for P in $PROG; do
	top -b -n1 |tail -n+7|awk --re-interval 'BEGIN{
							SIZE=0
							CPU=0
						}
						/'"$P"'/{
							PROGNAME=$12
							MEM+=$10
							CPU+=$9
						}
						END{
							if(length(PROGNAME)>8){gsub(".{3}$","",PROGNAME)}
							printf("|\t  %s \t|\t%.2f%%::%.2f Go\t| \t%.2f\t|\n",PROGNAME,MEM, (MEM*4)/100, CPU)
						}'
done
printf "+-----------------------+-----------------------+---------------+\n"
