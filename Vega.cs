using System;
using System.Collections.Generic;
using System.Drawing;
using System.Linq;
using System.Windows.Forms;
namespace Softcomputing
{
    class Vega : GeneticAlgorithm
    {
        private int _eliteClones = 5;
        /*
         * Elimination methods:
         * 1 - Linear
         * 2 - Quadrant
         * 3 - Cubic
         */
        private int _rouletteMethod = 1;
        private List<String> _popList = new List<string>();
        private List<Individual> _population;
        private string _function;
        private int iterations;
        
        public Individual getMinimum(bool ensure=true)
        {
            List<Individual> SortedList;
            if (ensure)
            {
                SortedList = _population.OrderBy(o => o.VALUE)
                    .Where(o =>
                        o.VALUE < EvaluateFunction(range.X2 - Math.Pow(10, -(long)ACC)) &&
                        o.VALUE < EvaluateFunction(range.X1 + Math.Pow(10, -(long)ACC))
                    ).ToList();
            }
            else
            {
                SortedList = _population.OrderBy(o => o.VALUE).ToList();
            }
            
            var meh = SortedList.FirstOrDefault();
            return SortedList.FirstOrDefault();
        }
        public List<String> getPopList()
        {
            return _popList;
        }
        
        public string FUNCTION
        {
            set
            {
                _function = value;
            }
            get
            {
                return _function;
            }
        }
       
        public Vega()
        {
            _population = new List<Individual>();
        }
        
        public void Start_params(int iterations, int populationSize, PointD range,
            int accuracy, float crossoverChance, float mutationChance)
        {
            _population.Clear();
            InitializePopulation(_population, populationSize, range, accuracy, crossoverChance, mutationChance);
            this.iterations = iterations;
        }
        
        public void DoWork()
        {
            int popsize = _population.Count;
            for (int i = 0; i < iterations; i++)
            {
                EvaluatePopulation();
                
                List<Individual> _subpopulation1 = new List<Individual>(_population);
                List<Individual> _subpopulation2 = new List<Individual>(_population);
                PerformSelection(ref _subpopulation1, 2, popsize);
                PerformSelection(ref _subpopulation2, 2, popsize);
                _population.Clear();
                _population.AddRange(_subpopulation1);
                _population.AddRange(_subpopulation2);
                Crossover(ref _population);
                Mutate(ref _population, 0.5f);
            }
            EvaluatePopulation();
        }
                
        void PerformSelection(ref List<Individual> subpopulation, int divider, int popsize)
        {
            var sorted = subpopulation.OrderBy(a => a.FITNESS).ThenByDescending(a => a.VALUE);
            List<Individual> tmp_pop = new List<Individual>(sorted.ToList());
            subpopulation.Clear();
            //diagnostyka
            //tworzymy koło ruletki
            ulong[] fitTable = new ulong[tmp_pop.Count + 1];
            fitTable[0] = 1;
            ulong tmp_popSize = (ulong)tmp_pop.Count;
            for (ulong i = 1; i < tmp_popSize; i++)//tworzymy tablice poglądową 1,2,3,5,8,... czyli pierwszy element ma 1 szansę, drugi 2, trzeci 3, czwarty 5, szósty 8
            {
                switch (_rouletteMethod)
                {
                    case 1:
                        fitTable[i] = fitTable[i - 1] + i;
                        break;
                    case 2:
                        fitTable[i] = (ulong)Math.Pow((i), 2);
                        break;
                    case 3:
                        fitTable[i] = (ulong)Math.Pow((i), 3);
                        break;
                }
            }
            //elitarne klony
            for (int i = 0; i < _eliteClones; i++)
            {
                subpopulation.Add(tmp_pop[tmp_pop.Count - 1]);
            }
            int iter = 0;
            for (int i = 0; i < (popsize / divider) - _eliteClones; i++)//wykonujemy N iteracji, gdzie N to liczba populacji
            {
                int a = RandomNumber.Instance.Next(0, (int)fitTable[tmp_pop.Count - 1]);// losujemy wartość od 0 do największej z tablicy poglądowej
                int index = Array.BinarySearch(fitTable, (ulong)a);//szukamy tą wartość, jeżeli nie ma tej wartości (np losujemy 6) to zwraca ujemny indeks kolejnej większej, czyli dla liczby 6 indeks to -4.
                if (index < 0)
                {
                    index = Math.Abs(index) - 1;
                }
                subpopulation.Add(tmp_pop[index]);
                if (index == tmp_pop.Count - 1)
                    iter++;
            }
        }
        
        void EvaluatePopulation()
        {
            foreach (Individual ind in _population)
            {
                ind.VALUE = EvaluateFunctionByIndividual(ind);
            }
        }
        
        public double EvaluateFunction(double x)
        {
            Variable variable = new Variable("x", x, 0, 0, 0, 0);
            Individual ind = new Individual(variable);
            return EvaluateFunctionByIndividual(ind);
        }
        double EvaluateFunctionByIndividual(Individual ind)
        {
            MathParserNet.SimplificationReturnValue retval;
            MathParserNet.Parser _mathParser = new MathParserNet.Parser();
            _mathParser.AddVariable(ind._point._name, ind._point._value);
            retval = _mathParser.Simplify(FUNCTION);
            if (retval.ReturnType == MathParserNet.SimplificationReturnValue.ReturnTypes.Float)
                return retval.DoubleValue;
            else
                return retval.IntValue;
        }
    }
}
