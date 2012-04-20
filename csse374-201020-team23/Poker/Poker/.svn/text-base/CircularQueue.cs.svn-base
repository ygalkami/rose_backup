using System;
using System.Collections.Generic;
using System.Linq;
using System.Text;
using System.Collections;

namespace Poker
{
    class CircularQueue
    {
        private int nMaxSize;
        private int nFrontPosition;
        private int nRearPosition;
        private ArrayList alstQueueContent;

        public CircularQueue(int MaxSize)
        {
            nMaxSize = MaxSize;
            nFrontPosition = 0;
            nRearPosition = -1;
            alstQueueContent = new ArrayList(MaxSize);
            for (int i = 0; i < nMaxSize; i++)
                alstQueueContent.Add(null);

        }
        public void resetQueue()
        {
            for (int i = 0; i < nMaxSize; i++)
                alstQueueContent[i] = null;
            nFrontPosition = 0;
            nRearPosition = -1;
        }
        public int frontPosition
        {
            get
            {
                return nFrontPosition;
            }
        }
        public int rearPosition
        {
            get
            {
                return nRearPosition;
            }
        }
        public bool enqueue(object obj)
        {
            if ((nRearPosition == (nMaxSize - 1) && nFrontPosition == 0) ||
                ((nRearPosition != -1) && (nRearPosition + 1) == nFrontPosition))
                return false;

            if (nRearPosition == (nMaxSize - 1) && nFrontPosition > 0)
            {
                nRearPosition = -1;
            }

            nRearPosition += 1;
            alstQueueContent[nRearPosition] = obj;
            if ((nRearPosition - 1) == nFrontPosition && alstQueueContent[nFrontPosition] == null)
                nFrontPosition = nFrontPosition + 1;
            return true;
        }

        public object dequeue()
        {
            object Output = "Empty";
            if (alstQueueContent[nFrontPosition] != null)
            {
                Output = alstQueueContent[nFrontPosition];
                alstQueueContent[nFrontPosition] = null;
                if ((nFrontPosition + 1) < nMaxSize && alstQueueContent[nFrontPosition + 1] != null)
                    nFrontPosition += 1;
                else if (alstQueueContent[0] != null && (nFrontPosition + 1) == nMaxSize)
                    nFrontPosition = 0;

            }
            return Output;
        }

        public object get(int i)
        {
            return alstQueueContent[i];
        }


        private bool IsQueueFull()
        {
            if (nFrontPosition == (nRearPosition - 1))
            {
                return true;
            }
            return false;
        }
    }
}
