using System;
using System.Collections.Generic;
using System.Linq;
using System.Text;

namespace Poker
{
	class NetworkNode
	{
        private LinkedList<NetworkNode> dependancies;
        private LinkedList<float> weights;
        public bool dirty;
        protected float output;

        public NetworkNode(){
            this.dependancies = new LinkedList<NetworkNode>();
		    this.weights = new LinkedList<float>();
		    this.dirty=true;
		    this.output=0.0f;
	    }
        public float getOutput()
        {
            return output;
        }
        public void UpdateOutput()
        {
            float max = 0.0f;
            this.output = 0.0f;
            ListIterator<NetworkNode> nodes = new ListIterator<NetworkNode>(dependancies);
            ListIterator<float> vals = new ListIterator<float>(weights);
            while (nodes.hasNext())
            {
                output += vals.next().Value * nodes.next().Value.getOutput();
                max += 1.0f;
            }
            //output /= max;
           // output *= 2.0f;
            output = (float)Math.Tanh(output);
           
            this.dirty = false;
        }
        public void addNode(NetworkNode node, float weight)
        {
            this.dependancies.AddLast(node);
            this.weights.AddLast(weight);
        }

        public void reinforceNode(float type)
        {
            ListIterator<NetworkNode> nodes = new ListIterator<NetworkNode>(dependancies);
            ListIterator<float> vals = new ListIterator<float>(weights);

            while (nodes.hasNext())
            {
                float value = vals.next().Value * nodes.next().Value.getOutput();
                if (value > 0.6)
                {
                    vals.current().Value += type;
                }
                else
                {
                    vals.current().Value -= type;
                }

                if (vals.current().Value > 1.0f)
                {
                    vals.current().Value = 1.0f;
                }
                if (vals.current().Value < -1.0f)
                {
                    vals.current().Value = -1.0f;
                }
                //type *= -1;
                if (nodes.current().Value.getOutput() > 0.6 && !(nodes.current().Value is InNetworkNode))
                {
                    nodes.current().Value.reinforceNode(type/2);
                }
                else
                {
                   nodes.current().Value.reinforceNode(-type/2);
                }
                

            }

        }
	}
}
