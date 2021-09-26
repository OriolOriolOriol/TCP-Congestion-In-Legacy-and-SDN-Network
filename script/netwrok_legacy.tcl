 #Make a NS simulator   
  set ns [new Simulator]	

  # Define a 'finish' procedure
  proc finish {} {
     exit 0
  }

  set n0 [$ns node]
  set n1 [$ns node]
  set n2 [$ns node]
  set n3 [$ns node]
  set n4 [$ns node]
  set n5 [$ns node]


  $ns duplex-link $n0 $n2 10Mb 	1ms  DropTail
  $ns duplex-link $n1 $n2 10Mb 	2ms  DropTail
  $ns duplex-link $n2 $n3 5Mb   20ms DropTail
  $ns duplex-link $n3 $n4 10Mb  3ms  DropTail
  $ns duplex-link $n3 $n5 10Mb	35ms DropTail

###MIO####
set errmod [new ErrorModel]
$errmod unit pkt
$errmod set rate_ 0.01
$errmod ranvar [new RandomVariable/Uniform]
$errmod drop-target [new Agent/Null]

$ns link-lossmodel $errmod $n2 $n3
########

  # Add a TCP sending module to node n0
  set tcp [new Agent/TCP/Vegas]
  #$ns at 0 "$tcp select_ca westwood"
  $ns attach-agent $n0 $tcp

  # Add a TCP receiving module to node n4
  set sink1 [new Agent/TCPSink]
  $ns attach-agent $n4 $sink1

  # Direct traffic from "tcp1" to "sink1"
  $ns connect $tcp $sink1

  # Setup a FTP traffic generator on "tcp1"
  set ftp1 [new Application/FTP]
  $ftp1 attach-agent $tcp
  $ftp1 set type_ FTP              

  # Schedule start/stop times
  $ns at 0.1   "$ftp1 start"
  $ns at 100.0 "$ftp1 stop"

  # Set simulation end time
  $ns at 125.0 "finish"		     


  ##################################################
  ## Obtain Trace date at destination (n4)
  ##################################################

  set trace_file [open  "out.tr"  w]

  $ns  trace-queue  $n3  $n4  $trace_file


  # Run simulation !!!!
  $ns run

