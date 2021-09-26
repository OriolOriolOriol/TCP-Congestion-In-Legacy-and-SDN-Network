#!/usr/bin/python

"""
This example shows how to create an empty Mininet object
(without a topology object) and add nodes to it manually.
"""
from mininet.node import CPULimitedHost
from mininet.topo import Topo
from mininet.net import Mininet
from mininet.log import setLogLevel, info
from mininet.node import RemoteController
from mininet.cli import CLI
from mininet.link import TCLink
from mininet.util import irange, quietRun
import os

def run():
    net = Mininet(topo=None, host=CPULimitedHost,controller=None,link=TCLink)
    info( '*** Adding controller\n' )
    net.addController("c0",controller=RemoteController,ip='127.0.0.1',port=6633)
    info( '*** Adding hosts\n' )
    h1 = net.addHost('h1',mac='00:00:00:00:00:01')
    h2 = net.addHost('h2',mac='00:00:00:00:00:02')
    h3 = net.addHost('h3',mac='00:00:00:00:00:03')
    h4 = net.addHost('h4',mac='00:00:00:00:00:04')
    info( '*** Adding switch\n' )
    s1 = net.addSwitch('s1', dpid="0000000000000001")
    s2 = net.addSwitch('s2', dpid="0000000000000002")
    info( '*** Creating links\n' )
    net.addLink( h1,s1,bw=10,delay='1ms')
    net.addLink( h2,s1,bw=10,delay='2ms')
    net.addLink( s1,s2,port1=10,port2=20,bw=5,delay='20ms',loss='0.01')
    net.addLink( h3,s2,bw=10,delay='3ms')
    net.addLink( h4,s2,bw=10,delay='35ms')

    info( '*** Starting network\n')
    net.start()
    info( '*** Running CLI\n' )
    CLI( net )
    info( '*** Stopping network\n' )
    net.stop()


if __name__ == '__main__':
    setLogLevel( 'info' )
    print "QUANDO HAI FINITO SCRIVI EXIT"
    run()
    #Killo il processo di mininet dopo l'utilizzo
    os.system('sudo mn -c')
