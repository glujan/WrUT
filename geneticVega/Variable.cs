using System;
using System.Collections.Generic;
using System.Linq;
using System.Text;
using System.Threading.Tasks;
namespace Softcomputing
{
    class Variable
    {
        public string _name;
        public double _value;
        public ulong _binaryValue;
        public int _bits_length;
        public double _min_value;
        public double _max_value;
        public Variable(string name, double value, ulong binVal, int bits, double min, double max)
        {
            _name = name;
            _value = value;
            _bits_length = bits;
            _binaryValue = binVal;
            _min_value = min;
            _max_value = max;
        }
    }
}
