using System;
using System.Drawing;
using System.Collections.Generic;
using System.Linq;
using System.Windows.Forms;
using System.Threading;
using System.ComponentModel;
namespace Softcomputing
{
    public partial class Main : Form
    {
        private Vega vega;
        private ZedGraph.LineItem minimumLine;
        private const int INTERVAL_COUNT = 5;
        BackgroundWorker progressbarWorker = new BackgroundWorker();
        public Main()
        {
            vega = new Vega();
            InitializeComponent();
            InitDefaultParams();
            progressbarWorker.WorkerReportsProgress = true;
            progressbarWorker.WorkerSupportsCancellation = true;
            progressbarWorker.DoWork += new DoWorkEventHandler(progressbarWorkerDoWorkHandler);
            progressbarWorker.ProgressChanged += new ProgressChangedEventHandler(progressbarWorkerProgressChangeHandler);
            progressbarWorker.RunWorkerCompleted += new RunWorkerCompletedEventHandler(progressbarWorkerCompletedHandler);
            minArgumentBox.TextChanged += new System.EventHandler(drawGraph);
            maxArgumentBox.TextChanged += new System.EventHandler(drawGraph);
        }
        private void InitDefaultParams()
        {
            string[] comboBoxItems = {
                "(x-2)*(x-4)*(x-5)*(x+2)*(x+3)*(x+5)",
                "x^2",
                "(x-1)^2",
                "x^3 + x^2"
            };
            numericCrossover.Value = 0.9M;
            numericIterations.Value = 100;
            numericMutate.Value = 0.02M;
            numericPopulationSize.Value = 100;
            numericAccuracy.Value = 5;
            minArgumentBox.Value = -5;
            maxArgumentBox.Value = 5;
            progressBar.Step = 5;
            progressBar.Value = 0;
            progressBar.Maximum = 100;
            progressBar.Visible = false;
            listBoxResults.DisplayMember = "Text";
            comboBoxFunction.Items.AddRange(comboBoxItems);
            comboBoxFunction.SelectedIndex = 0;
            zedGraphControl.GraphPane.Title.Text = "Selected function";
        }
        private void start_button_Click(object sender, EventArgs e)
        {
            drawGraph(sender, e);
            listBoxResults.DataSource = null;
            progressBar.Visible = true;
            progressBar.Value = 0;
            progressBar.Maximum = Convert.ToInt32(numericIterations.Value);
            BackgroundWorker vegaWorker = new BackgroundWorker();
            vegaWorker.DoWork += new DoWorkEventHandler(vegaWroker_DoWorkHandler);
            vegaWorker.RunWorkerCompleted += new RunWorkerCompletedEventHandler(vegaWorker_CompletedHandler);
            string function = comboBoxFunction.Text;
            vegaWorker.RunWorkerAsync(function);
            progressbarWorker = new BackgroundWorker();
            progressbarWorker.RunWorkerAsync();
        }
        private void progressbarWorkerCompletedHandler(object sender, RunWorkerCompletedEventArgs e)
        {
            progressBar.Value = 0;
            progressBar.Visible = false;
        }
        private void progressbarWorkerProgressChangeHandler(object sender, ProgressChangedEventArgs e)
        {
            progressBar.Value = e.ProgressPercentage;
        }
        private void progressbarWorkerDoWorkHandler(object sender, DoWorkEventArgs e)
        {
            BackgroundWorker worker = sender as BackgroundWorker;
            int progress = progressBar.Value;
            while (progressBar.Value < progressBar.Maximum)
            {
                if (worker.CancellationPending)
                {
                    e.Cancel = true;
                    break;
                }
                else
                {
                    progress += progressBar.Step;
                    worker.ReportProgress(progress);
                    Thread.Sleep(80);
                }                
            }
        }
        private void vegaWroker_DoWorkHandler(object sender, DoWorkEventArgs e)
        {
            List<Individual> minimums = new List<Individual>();
            Dictionary<Vega, Thread> threadsDict = new Dictionary<Vega, Thread>();
            float start = (float)minArgumentBox.Value;
            float end = (float)maxArgumentBox.Value;
            float step = (end - start) / INTERVAL_COUNT;
            foreach (int i in Enumerable.Range(0, INTERVAL_COUNT))
            {
                Vega vega = new Vega();
                vega.FUNCTION = (string)e.Argument;
                vega.Start_params(
                    Convert.ToInt32(numericIterations.Value),
                    Convert.ToInt32(numericPopulationSize.Value),
                    new PointD(start, start + step),
                    Convert.ToInt32(numericAccuracy.Value),
                    (float)numericCrossover.Value,
                    (float)numericMutate.Value
                );
                Thread workerThread = new Thread(vega.DoWork);
                threadsDict.Add(vega, workerThread);
                workerThread.Start();
                while (!workerThread.IsAlive);
                start += step;
            }
            foreach (var pair in threadsDict)
            {
                pair.Value.Join();
                Individual ind = pair.Key.getMinimum();
                if (ind != null)
                {
                    minimums.Add(ind);
                }
            }
            e.Result = minimums;
        }
        private void vegaWorker_CompletedHandler(object sender, RunWorkerCompletedEventArgs e)
        {            
            List<Individual> minimums = (List<Individual>)e.Result;
            List<string> stringMins = minimums.OrderBy(o => o.VALUE).Select(o => o.ToString()).ToList();
            if (stringMins.Count > 0)
            {
                drawCurve(
                    minimumLine,
                    minimums.Select(min => min.ARG).ToArray(),
                    minimums.Select(min => min.VALUE).ToArray()
                );
            }
            else
            {
                stringMins.Add("No minimum!");
            }
            listBoxResults.DataSource = stringMins;
            progressBar.Visible = false;
        }
        private void drawGraph(object sender, EventArgs e)
        {
            ZedGraph.GraphPane pane = zedGraphControl.GraphPane;
            pane.CurveList.Clear();
            listBoxResults.DataSource = null;
            double step = 0.2;
            double min = Convert.ToDouble(minArgumentBox.Value);
            double max = Convert.ToDouble(maxArgumentBox.Value);
            int size = Convert.ToInt32((max - min) / step) + 1;
            double[] x = new double[size];
            double[] y = new double[size];
            string function = comboBoxFunction.Text;
            vega.FUNCTION = function;
            foreach (int i in Enumerable.Range(0, size))
            {
                x[i] = min + i * step;
                y[i] = vega.EvaluateFunction(x[i]);
            }
            drawCurve(function, x, y, System.Drawing.Color.Blue);
            drawIntervals(x, y);
            minimumLine = createLine(
                "minimums",
                System.Drawing.Color.Red,
                ZedGraph.SymbolType.Diamond,
                false
            );
        }
        private void drawIntervals(double[] x, double[] y)
        {
            double minValue = y.Min();
            double maxValue = y.Max();
            double start = x.Min();
            double end = x.Max();
            double step = (end - start) / INTERVAL_COUNT;
            for (int i = 0; i <= INTERVAL_COUNT; i += 1)
            {
                double[] xInterval = { start + i * step, start + i * step };
                double[] yInterval = { minValue, maxValue };
                zedGraphControl.GraphPane.AddStick("", xInterval, yInterval, Color.LightSalmon);
            }
            zedGraphControl.Refresh();
        }
        private ZedGraph.LineItem createLine(string name, System.Drawing.Color color,
            ZedGraph.SymbolType symbol = ZedGraph.SymbolType.None, bool visibleLine = true)
        {
            double[] empty = { };
            ZedGraph.GraphPane pane = zedGraphControl.GraphPane;
            ZedGraph.LineItem line = pane.AddCurve(name, empty, empty, color, symbol);
            line.Line.IsVisible = visibleLine;
            return line;
        }
        private void drawCurve(ZedGraph.LineItem line, double[] x, double[] y)
        {
            line.Points = new ZedGraph.PointPairList(x, y);
            zedGraphControl.AxisChange();
            zedGraphControl.Invalidate();
            zedGraphControl.Refresh();
        }
        private void drawCurve(string name, double[] x, double[] y, System.Drawing.Color color,
            ZedGraph.SymbolType symbol = ZedGraph.SymbolType.None, bool visibleLine = true)
        {
            ZedGraph.LineItem line = createLine(name, color, symbol, visibleLine);
            drawCurve(line, x, y);
        }
    }
}
