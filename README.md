
    # *** Detection of malicious nodes in wireless sensing network using weighted trust evaluation method ***


In this we consider an area in which we randomly distribute sensing nodes and we make few random cluster heads. We assume that only the cluster heads are able to communicate with the main system. So instead of sending message from the node to main system, we send data to the cluster head and from that cluster head to the main system.

We consider that there is a sequence of data in binary form from all the nodes 
to cluster head. A good node sends the data as it is while a bad or malicious node may or may not flip the data (1 to 0 or 0 to 1) so we check if the bit is inverted then we reduce the trust which is considered to be 1 by 0.2(penalty factor). If the trust of any node become less than 0.4, then we consider that node as malicious node
