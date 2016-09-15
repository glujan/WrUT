using System;
using System.Collections.Generic;
using System.Linq;
using System.Text;
using System.Threading.Tasks;
using System.Diagnostics;
using System.Drawing;
using System.Windows.Forms;
namespace Softcomputing
{
    class GeneticAlgorithm
    {
        private float _crossover_probability;
        private float _mutation_probability;
        private ulong _accuracy;
        protected PointD range;
        #region GET and SET
        public float CP
        {
            get
            {
                return _crossover_probability;
            }
            set
            {
                _crossover_probability = value;
            }
        }
        public float MP
        {
            get
            {
                return _mutation_probability;
            }
            set
            {
                _mutation_probability = value;
            }
        }
        public ulong ACC
        {
            get
            {
                return _accuracy;
            }
            set
            {
                _accuracy = value;
            }
        }
        #endregion
        protected void InitializePopulation(List<Individual> population, int populationSize,
            PointD range, int accuracy, float crossoverChance, float mutationChance)
        {
            this.range = range;
            if (accuracy > 18)
            {
                MessageBox.Show("To high accuracy! Setting it to 18");
                accuracy = 18;
            }
            ACC = (ulong)Math.Pow(10, accuracy);
            CP = crossoverChance;
            MP = mutationChance;
            if (GetBitCount(range.X1, range.X2) > 64)
            {
                MessageBox.Show("To much bits");
            }
            for (int i = 0; i < populationSize; i++)
                population.Add(newIndividual());
        }
        protected Individual newIndividual()
        {
            int bits = 0;
            double tmp = (range.X1 + (range.X2 - range.X1) * (RandomNumber.Instance.NextDouble()));
            ulong bin = GetBinaryOr(tmp, ref bits, range.X1, range.X2);
            Variable variable = new Variable("x", tmp, bin, bits, range.X1, range.X2);
            return new Individual(variable);
        }
        protected void Crossover(ref List<Individual> population)
        {
            List<Individual> crossed = new List<Individual>();
            population.RemoveAt(0);
            crossed.Add(population[population.Count - 1]);
            int pop_cout = population.Count();
            for (int i = 0; i < (pop_cout) / 2; i++)
            {
                if (RandomNumber.Instance.NextDouble() <= _crossover_probability)
                {
                    int randInt = RandomNumber.Instance.Next(0, population.Count);
                    Individual parent1 = population[randInt];
                    population.RemoveAt(randInt);
                    randInt = RandomNumber.Instance.Next(0, population.Count);
                    Individual parent2 = population[randInt];
                    population.RemoveAt(randInt);
                    RandomAverageFloatCrossover(parent1, parent2, ref crossed);
                }
            }
            population.AddRange(crossed);
        }
        private void RandomAverageFloatCrossover(Individual p1, Individual p2, ref List<Individual> population)
        {
            double randD = RandomNumber.Instance.NextDouble();
            double child1Avg = p1._point._value + randD * (p2._point._value - p1._point._value);
            double child2Avg = (p2._point._value + p1._point._value - child1Avg);
            int bits1 = 0;
            int bits2 = 0;
            ulong bin1 = GetBinaryOr(child1Avg, ref bits1, range.X1, range.X2);
            ulong bin2 = GetBinaryOr(child2Avg, ref bits2, range.X1, range.X2);
            Variable child1Var = new Variable(p2._point._name, child1Avg, bin1, bits1, p2._point._min_value, p2._point._max_value);
            Variable child2Var = new Variable(p2._point._name, child2Avg, bin2, bits2, p2._point._min_value, p2._point._max_value);
            Individual child1 = new Individual(child1Var);
            Individual child2 = new Individual(child2Var);
            population.Add(child1);
            population.Add(child2);
        }
        protected void Mutate(ref List<Individual> population, double AdditionalParameters)
        {
            BitFlipMutation_AllBitsSameChance(population, (int)AdditionalParameters);
        }
        /*
         * Mutation, every bit has mutation chance
         * significance- mutation range, 0-all bits, x-bits from 0 to x
         */
        private void BitFlipMutation_AllBitsSameChance(List<Individual> population, int significance)
        {
            foreach (Individual ind in population)
            {
                for (ulong i = 0; i < (ulong)(ind._point._bits_length - significance); i++)
                {
                    if (RandomNumber.Instance.NextDouble() <= _mutation_probability)//jeżeli warunek na krzyżowanie jest spełnione//
                    {
                        ind._point._binaryValue ^= ((ulong)1 << (int)i);
                        double tmp = GetDouble(ind._point._binaryValue, ind._point._min_value, ind._point._max_value);
                        ind._point._value = tmp;
                    }
                }
            }
        }
        private ulong GetBinaryOr(double x, ref int Bits, double min, double max)
        {
            ulong Bins = (ulong)(max - min) * ACC;
            Bits = (int)Math.Ceiling(Math.Log(Bins, 2d));
            ulong Scaled = (ulong)((Math.Pow(2, Bits) * (x - min)) / (max - min));
            return Scaled;
        }
        private int GetBitCount(double min, double max)
        {
            ulong Bins = (ulong)(max - min) * ACC;
            return (int)Math.Ceiling(Math.Log(Bins, 2d));
        }
        private double GetDouble(ulong bin, double min, double max)
        {
            ulong Bins = (ulong)(max - min) * ACC;
            int Bits = (int)Math.Ceiling(Math.Log(Bins, 2d));
            return (((max - min) * (bin - 0)) / (Math.Pow(2, Bits) - 0) + min);
        }
        private static string ToBinary(Int64 Decimal)
        {
            Int64 BinaryHolder;
            char[] BinaryArray;
            string BinaryResult = "";
            while (Decimal > 0)
            {
                BinaryHolder = Decimal % 2;
                BinaryResult += BinaryHolder;
                Decimal = Decimal / 2;
            }
            BinaryArray = BinaryResult.ToCharArray();
            Array.Reverse(BinaryArray);
            BinaryResult = new string(BinaryArray);
            return BinaryResult;
        }
    }
}
