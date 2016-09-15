using System;
using System.Collections.Generic;
using System.Linq;
using System.Text;
using System.Threading;
namespace Softcomputing
{
    public static class RandomNumber
    {
        private static int seed;
        private static ThreadLocal<Random> threadLocal = new ThreadLocal<Random>
            (() => new Random(Interlocked.Increment(ref seed)));
        static RandomNumber()
        {
            seed = Environment.TickCount;
        }
        public static Random Instance { get { return threadLocal.Value; } }
    }
}
