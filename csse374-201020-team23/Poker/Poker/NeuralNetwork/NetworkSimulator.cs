using System;
using System.Collections.Generic;
using System.Linq;
using System.Text;

namespace Poker
{
    class NetworkSimulator
    {
        Network neuralNet;
        MainWindow win;

        public NetworkSimulator(MainWindow window)
        {
            win = window;
            neuralNet = new Network();
            trainNetwork();
            testNetwork();
        }

        public void trainNetwork()
        {
            Random R = new Random();
            int randValue = 0;

            for (int i = 0; i <2000; i++)
            {
                randValue = R.Next(2);

                float[] input = Letters.inputSets[randValue];
                float[] output = Letters.outputSets[randValue];

                neuralNet.pushInputs(input);
                float[] resultSet = neuralNet.pullOutputs();

                for (int j = 0; j < 4; j++)
                {
                    if (resultSet[j] == output[j])
                    {
                        neuralNet.getOutputNode(j).reinforceNode(0.002f);
                    }
                    if (resultSet[j] != output[j])
                    {
                        neuralNet.getOutputNode(j).reinforceNode(-0.001f);
                    }
                }            
            }
        }

        public void testNetwork()
        {
            for (int i = 0; i < 2; i++)
            {
                neuralNet.pushInputs(Letters.inputSets[i]);
                float[] result = neuralNet.pullOutputs();

                String s = "";
                for (int k = 0; k < 4; k++)
                {
                    s += result[k];
                }
                
                //win.neuralNetDisplay(s);

            }
        }

    }
}
