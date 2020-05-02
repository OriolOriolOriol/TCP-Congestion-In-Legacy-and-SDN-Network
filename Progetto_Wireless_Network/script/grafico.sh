gnuplot <<- EOF
        set xlabel "Time(s)"
        set ylabel "Throughput(Bits)"
        set title "TCP New-reno vs TCP Vegas vs TCP Westwood (n0-n4)"   
        set term png
	set key bmargin
	set style line 1 lt rgb "red" lw 2
	set style line 5 lt rgb "cyan" lw 2
	set style line 6 lt rgb "orange" lw 2
        set output "finale5.png"
        plot "Newrenofinale2" with l ls 6, "Westwoodfinale2" with l ls 1 , "Vegasfinale2" with l ls 5 
EOF

