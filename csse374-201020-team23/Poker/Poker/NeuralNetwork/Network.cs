using System;
using System.Collections.Generic;
using System.Linq;
using System.Text;

namespace Poker
{
    
	class Network
	{
        const int ROW = 1;
        const int COL = 0;
        private LinkedList<InNetworkNode> inlayer;
        private LinkedList<NetworkNode> outlayer;
        private LinkedList<NetworkNode> hlayer1;
        private LinkedList<NetworkNode> hlayer2;

        public Network()
        {
            Random R = new Random();
            inlayer = new LinkedList<InNetworkNode>();
            outlayer = new LinkedList<NetworkNode>();
            hlayer1 = new LinkedList<NetworkNode>();
            hlayer2 = new LinkedList<NetworkNode>();
            for (int i = 0; i < 14; i++)
            {
                InNetworkNode bob = new InNetworkNode();
                inlayer.AddLast(bob);
            }
            for (int i = 0; i < 28; i++)
            {
                NetworkNode bob = new NetworkNode();
                hlayer1.AddLast(bob);
                ListIterator<InNetworkNode> iter = new ListIterator<InNetworkNode>(inlayer);
                int n = 0;
                int m = 0;
                int col=0;
                int type = 0;
                switch (i)
                {
                    case 0: { n = 0; m = 2; type = ROW; } break;
                    case 1: { n = 3; m = 5; type = ROW; } break;
                    case 2: { n = 6; m = 8; type = ROW; } break;
                    case 3: { n = 9; m = 11; type = ROW; } break;
                    case 4: { n = 12; m = 14; type = ROW; } break;
                    case 5: { col=0; type = COL; } break;
                    case 6: { col=1; type = COL; } break;
                    case 7: { col=2; type = COL; } break;
                }
                 /*
                 if (type == ROW)
                {
                    for (int j = n; j <= m; j++)
                    {
                        bob.addNode(inlayer.ElementAt(j), (float)R.NextDouble() * 2 - 1);
                    }
                }
                else
                {
                    switch (col)
                    {
                        case 0: {
                            bob.addNode(inlayer.ElementAt(0), (float)R.NextDouble() * 2 - 1);
                            bob.addNode(inlayer.ElementAt(3), (float)R.NextDouble() * 2 - 1);
                            bob.addNode(inlayer.ElementAt(6), (float)R.NextDouble() * 2 - 1);
                            bob.addNode(inlayer.ElementAt(9), (float)R.NextDouble() * 2 - 1);
                            bob.addNode(inlayer.ElementAt(12), (float)R.NextDouble() * 2 - 1);
                        } break;
                        case 1: {
                            bob.addNode(inlayer.ElementAt(1), (float)R.NextDouble() * 2 - 1);
                            bob.addNode(inlayer.ElementAt(4), (float)R.NextDouble() * 2 - 1);
                            bob.addNode(inlayer.ElementAt(7), (float)R.NextDouble() * 2 - 1);
                            bob.addNode(inlayer.ElementAt(10), (float)R.NextDouble() * 2 - 1);
                            bob.addNode(inlayer.ElementAt(13), (float)R.NextDouble() * 2 - 1);
                        } break;
                        case 2: {
                            bob.addNode(inlayer.ElementAt(2), (float)R.NextDouble() * 2 - 1);
                            bob.addNode(inlayer.ElementAt(5), (float)R.NextDouble() * 2 - 1);
                            bob.addNode(inlayer.ElementAt(8), (float)R.NextDouble() * 2 - 1);
                            bob.addNode(inlayer.ElementAt(11), (float)R.NextDouble() * 2 - 1);
                            bob.addNode(inlayer.ElementAt(14), (float)R.NextDouble() * 2 - 1);
                        } break;
                    }
                }
               */
                
                for (int j = 0; j < 15; j++)
                {
                    bob.addNode(iter.next().Value, (float)R.NextDouble());
                }
                 
            }
            
            for (int i = 0; i < 14; i++)
            {
                NetworkNode bob = new NetworkNode();
                hlayer2.AddLast(bob);
                ListIterator<NetworkNode> iter2 = new ListIterator<NetworkNode>(hlayer1);
                for (int j = 0; j < 8; j++)
                {
                    bob.addNode(iter2.next().Value, (float)R.NextDouble() * 2 - 1);
                }
            }
            
            for (int i = 0; i < 4; i++)
            {
                NetworkNode bob = new NetworkNode();
                outlayer.AddLast(bob);
                ListIterator<NetworkNode> iter = new ListIterator<NetworkNode>(hlayer2);
                for (int j = 0; j < 8; j++)
                {
                    bob.addNode(iter.next().Value, (float)R.NextDouble() * 2 - 1);
                }
            }
        }
        public void pushInputs(float[] farray){
    		ListIterator<InNetworkNode> iter = new ListIterator<InNetworkNode>(this.inlayer);
    		int i = 0;
    		while(iter.hasNext()){
                InNetworkNode bob = iter.next().Value;
    			bob.setOutput(farray[i]);
    			i++;
    		}
	    }

        public float[] pullOutputs(){
    		ListIterator<NetworkNode> iterhidden1 = new  ListIterator<NetworkNode>(hlayer1);
            ListIterator<NetworkNode> iterhidden2 = new ListIterator<NetworkNode>(hlayer2);
    		ListIterator<NetworkNode> iterout = new  ListIterator<NetworkNode>(outlayer);
    		while(iterhidden1.hasNext()){
    			iterhidden1.next().Value.UpdateOutput();
    		}
            
            while (iterhidden2.hasNext())
            {
                iterhidden2.next().Value.UpdateOutput();
            }
            
    		while(iterout.hasNext()){
    		    iterout.next().Value.UpdateOutput();
    		}
    		ListIterator<NetworkNode> iterfinal = new ListIterator<NetworkNode>(outlayer);
    		int i = 0;
    		float[] barray = new float[4];
    		while(iterfinal.hasNext()){
    			NetworkNode bob = iterfinal.next().Value;
    			barray[i] = (bob.getOutput())>0.6f?1:0;
    			i++;
    		}
    		return barray;
	    }
        

        public NetworkNode getOutputNode(int position)
        {
            return outlayer.ElementAt(position);
        }

	}
}
