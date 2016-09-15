using System;
using System.Collections.Generic;
using System.Linq;
using System.Text;
using System.Threading.Tasks;
namespace Softcomputing
{
    class Individual
    {
        private double _value;
        private double _fitness;
        public Variable _point;
        #region GET and SET
        public double VALUE
        {
            get
            {
                return _value;
            }
            set
            {
                _value = value;
            }
        }
        public double FITNESS
        {
            get
            {
                return _fitness;
            }
            set
            {
                _fitness = value;
            }
        }
        public double ARG
        {
            get
            {
                return _point._value;
            }
        }
        #endregion
        public Individual(Variable var)
        {
            _point = var;
            _value = 0;
            _fitness = 1;
        }
        public static double _compare(Individual x, Individual y)
        {
            if (x.FITNESS != y.FITNESS)
            {
                return x.FITNESS - y.FITNESS;
            }
            else
                return x.VALUE - y.VALUE;
        }
        override public string ToString()
        {
            return "X: " + ARG + ", value: " + VALUE;
        }
    }
}
