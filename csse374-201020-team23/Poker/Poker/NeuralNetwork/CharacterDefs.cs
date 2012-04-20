namespace Poker
{
    class Letters
    {
        public static float[] A1in = { 0, 0, 0, 0, 1, 0, 1, 0, 1, 1, 1, 1, 1, 0, 1 };
        public static float[] A2in = { 0, 0, 0, 1, 1, 1, 1, 0, 1, 1, 1, 1, 1, 0, 1 };
        public static float[] B1in = { 1, 1, 0, 1, 0, 1, 1, 1, 1, 1, 0, 1, 1, 1, 0 };
        public static float[] B2in = { 1, 1, 1, 1, 0, 1, 1, 1, 1, 1, 0, 1, 1, 1, 1 };
        public static float[] C1in = { 0, 1, 1, 1, 0, 0, 1, 0, 0, 1, 0, 0, 0, 1, 1 };
        public static float[] C2in = { 1, 1, 1, 1, 0, 0, 1, 0, 0, 1, 0, 0, 1, 1, 1 };
        public static float[] D1in = { 1, 1, 0, 1, 0, 1, 1, 0, 1, 1, 0, 1, 1, 1, 0 };
        public static float[] D2in = { 1, 1, 1, 1, 0, 1, 1, 0, 1, 1, 0, 1, 1, 1, 1 };

       // public static float[][] inputSets = {A1in, A2in, B1in, B2in, C1in, C2in, D1in, D2in};
        public static float[][] inputSets = { A1in, C1in};//, C1in, D1in };

        public static float[] A1out = { 1, 0, 0, 0 };
        public static float[] A2out = { 1, 0, 0, 0 };
        public static float[] B1out = { 0, 1, 0, 0 };
        public static float[] B2out = { 0, 1, 0, 0 };
        public static float[] C1out = { 0, 0, 1, 0 };
        public static float[] C2out = { 0, 0, 1, 0 };
        public static float[] D1out = { 0, 0, 0, 1 };
        public static float[] D2out = { 0, 0, 0, 1 };

       // public static float[][] outputSets = { A1out, A2out, B1out, B2out, C1out, C2out, D1out, D2out };
        public static float[][] outputSets = { A1out, C1out};//, C1out, D1out };
    }
}