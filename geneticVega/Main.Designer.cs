namespace Softcomputing
{
    partial class Main
    {
        /// <summary>
        /// Required designer variable.
        /// </summary>
        private System.ComponentModel.IContainer components = null;
        /// <summary>
        /// Clean up any resources being used.
        /// </summary>
        /// <param name="disposing">true if managed resources should be disposed; otherwise, false.</param>
        protected override void Dispose(bool disposing)
        {
            if (disposing && (components != null))
            {
                components.Dispose();
            }
            base.Dispose(disposing);
        }
        #region Windows Form Designer generated code
        /// <summary>
        /// Required method for Designer support - do not modify
        /// the contents of this method with the code editor.
        /// </summary>
        private void InitializeComponent()
        {
            this.components = new System.ComponentModel.Container();
            this.start_button = new System.Windows.Forms.Button();
            this.labelParameters = new System.Windows.Forms.Label();
            this.labelCrossover = new System.Windows.Forms.Label();
            this.labelMutate = new System.Windows.Forms.Label();
            this.labelAccuracy = new System.Windows.Forms.Label();
            this.labelRanges = new System.Windows.Forms.Label();
            this.numericCrossover = new System.Windows.Forms.NumericUpDown();
            this.numericMutate = new System.Windows.Forms.NumericUpDown();
            this.numericAccuracy = new System.Windows.Forms.NumericUpDown();
            this.minArgumentBox = new System.Windows.Forms.NumericUpDown();
            this.maxArgumentBox = new System.Windows.Forms.NumericUpDown();
            this.labelPopulationSize = new System.Windows.Forms.Label();
            this.numericPopulationSize = new System.Windows.Forms.NumericUpDown();
            this.label11 = new System.Windows.Forms.Label();
            this.numericIterations = new System.Windows.Forms.NumericUpDown();
            this.comboBoxFunction = new System.Windows.Forms.ComboBox();
            this.label12 = new System.Windows.Forms.Label();
            this.progressBar = new System.Windows.Forms.ProgressBar();
            this.zedGraphControl = new ZedGraph.ZedGraphControl();
            this.listBoxResults = new System.Windows.Forms.ListBox();
            this.label1 = new System.Windows.Forms.Label();
            ((System.ComponentModel.ISupportInitialize)(this.numericCrossover)).BeginInit();
            ((System.ComponentModel.ISupportInitialize)(this.numericMutate)).BeginInit();
            ((System.ComponentModel.ISupportInitialize)(this.numericAccuracy)).BeginInit();
            ((System.ComponentModel.ISupportInitialize)(this.minArgumentBox)).BeginInit();
            ((System.ComponentModel.ISupportInitialize)(this.maxArgumentBox)).BeginInit();
            ((System.ComponentModel.ISupportInitialize)(this.numericPopulationSize)).BeginInit();
            ((System.ComponentModel.ISupportInitialize)(this.numericIterations)).BeginInit();
            this.SuspendLayout();
            // 
            // start_button
            // 
            this.start_button.Anchor = System.Windows.Forms.AnchorStyles.Bottom;
            this.start_button.Location = new System.Drawing.Point(380, 462);
            this.start_button.Name = "start_button";
            this.start_button.Size = new System.Drawing.Size(100, 44);
            this.start_button.TabIndex = 0;
            this.start_button.Text = "Start";
            this.start_button.UseVisualStyleBackColor = true;
            this.start_button.Click += new System.EventHandler(this.start_button_Click);
            // 
            // labelParameters
            // 
            this.labelParameters.AutoSize = true;
            this.labelParameters.Font = new System.Drawing.Font("Microsoft Sans Serif", 15.75F, System.Drawing.FontStyle.Regular, System.Drawing.GraphicsUnit.Point, ((byte)(238)));
            this.labelParameters.Location = new System.Drawing.Point(7, 12);
            this.labelParameters.Name = "labelParameters";
            this.labelParameters.Size = new System.Drawing.Size(195, 25);
            this.labelParameters.TabIndex = 3;
            this.labelParameters.Text = "Evolution algorithm";
            // 
            // labelCrossover
            // 
            this.labelCrossover.AutoSize = true;
            this.labelCrossover.Cursor = System.Windows.Forms.Cursors.Default;
            this.labelCrossover.Location = new System.Drawing.Point(87, 178);
            this.labelCrossover.Name = "labelCrossover";
            this.labelCrossover.Size = new System.Drawing.Size(104, 13);
            this.labelCrossover.TabIndex = 4;
            this.labelCrossover.Text = "Crossover porbability";
            // 
            // labelMutate
            // 
            this.labelMutate.AutoSize = true;
            this.labelMutate.Location = new System.Drawing.Point(93, 204);
            this.labelMutate.Name = "labelMutate";
            this.labelMutate.Size = new System.Drawing.Size(98, 13);
            this.labelMutate.TabIndex = 5;
            this.labelMutate.Text = "Mutation probability";
            // 
            // labelAccuracy
            // 
            this.labelAccuracy.AutoSize = true;
            this.labelAccuracy.Location = new System.Drawing.Point(136, 229);
            this.labelAccuracy.Name = "labelAccuracy";
            this.labelAccuracy.Size = new System.Drawing.Size(55, 13);
            this.labelAccuracy.TabIndex = 6;
            this.labelAccuracy.Text = "Precission";
            // 
            // labelRanges
            // 
            this.labelRanges.AutoSize = true;
            this.labelRanges.Location = new System.Drawing.Point(147, 255);
            this.labelRanges.Name = "labelRanges";
            this.labelRanges.Size = new System.Drawing.Size(44, 13);
            this.labelRanges.TabIndex = 12;
            this.labelRanges.Text = "Ranges";
            // 
            // numericCrossover
            // 
            this.numericCrossover.DecimalPlaces = 2;
            this.numericCrossover.Increment = new decimal(new int[] {
            1,
            0,
            0,
            65536});
            this.numericCrossover.Location = new System.Drawing.Point(197, 175);
            this.numericCrossover.Maximum = new decimal(new int[] {
            1,
            0,
            0,
            0});
            this.numericCrossover.Name = "numericCrossover";
            this.numericCrossover.Size = new System.Drawing.Size(100, 20);
            this.numericCrossover.TabIndex = 7;
            // 
            // numericMutate
            // 
            this.numericMutate.DecimalPlaces = 2;
            this.numericMutate.Increment = new decimal(new int[] {
            1,
            0,
            0,
            65536});
            this.numericMutate.Location = new System.Drawing.Point(197, 201);
            this.numericMutate.Maximum = new decimal(new int[] {
            1,
            0,
            0,
            0});
            this.numericMutate.Name = "numericMutate";
            this.numericMutate.Size = new System.Drawing.Size(100, 20);
            this.numericMutate.TabIndex = 8;
            // 
            // numericAccuracy
            // 
            this.numericAccuracy.Location = new System.Drawing.Point(197, 226);
            this.numericAccuracy.Maximum = new decimal(new int[] {
            18,
            0,
            0,
            0});
            this.numericAccuracy.Name = "numericAccuracy";
            this.numericAccuracy.Size = new System.Drawing.Size(100, 20);
            this.numericAccuracy.TabIndex = 9;
            // 
            // minArgumentBox
            // 
            this.minArgumentBox.Location = new System.Drawing.Point(197, 252);
            this.minArgumentBox.Minimum = new decimal(new int[] {
            100,
            0,
            0,
            -2147483648});
            this.minArgumentBox.Name = "minArgumentBox";
            this.minArgumentBox.Size = new System.Drawing.Size(49, 20);
            this.minArgumentBox.TabIndex = 13;
            // 
            // maxArgumentBox
            // 
            this.maxArgumentBox.Location = new System.Drawing.Point(252, 252);
            this.maxArgumentBox.Minimum = new decimal(new int[] {
            100,
            0,
            0,
            -2147483648});
            this.maxArgumentBox.Name = "maxArgumentBox";
            this.maxArgumentBox.Size = new System.Drawing.Size(45, 20);
            this.maxArgumentBox.TabIndex = 15;
            // 
            // labelPopulationSize
            // 
            this.labelPopulationSize.AutoSize = true;
            this.labelPopulationSize.Location = new System.Drawing.Point(113, 152);
            this.labelPopulationSize.Name = "labelPopulationSize";
            this.labelPopulationSize.Size = new System.Drawing.Size(78, 13);
            this.labelPopulationSize.TabIndex = 46;
            this.labelPopulationSize.Text = "Population size";
            // 
            // numericPopulationSize
            // 
            this.numericPopulationSize.Increment = new decimal(new int[] {
            10,
            0,
            0,
            0});
            this.numericPopulationSize.Location = new System.Drawing.Point(197, 149);
            this.numericPopulationSize.Maximum = new decimal(new int[] {
            1000,
            0,
            0,
            0});
            this.numericPopulationSize.Minimum = new decimal(new int[] {
            1,
            0,
            0,
            0});
            this.numericPopulationSize.Name = "numericPopulationSize";
            this.numericPopulationSize.Size = new System.Drawing.Size(100, 20);
            this.numericPopulationSize.TabIndex = 47;
            this.numericPopulationSize.Value = new decimal(new int[] {
            1,
            0,
            0,
            0});
            // 
            // label11
            // 
            this.label11.AutoSize = true;
            this.label11.Location = new System.Drawing.Point(111, 129);
            this.label11.Name = "label11";
            this.label11.Size = new System.Drawing.Size(80, 13);
            this.label11.TabIndex = 48;
            this.label11.Text = "Iterations count";
            // 
            // numericIterations
            // 
            this.numericIterations.Increment = new decimal(new int[] {
            10,
            0,
            0,
            0});
            this.numericIterations.Location = new System.Drawing.Point(197, 126);
            this.numericIterations.Maximum = new decimal(new int[] {
            1000,
            0,
            0,
            0});
            this.numericIterations.Name = "numericIterations";
            this.numericIterations.Size = new System.Drawing.Size(100, 20);
            this.numericIterations.TabIndex = 49;
            // 
            // comboBoxFunction
            // 
            this.comboBoxFunction.FormattingEnabled = true;
            this.comboBoxFunction.Location = new System.Drawing.Point(12, 99);
            this.comboBoxFunction.Name = "comboBoxFunction";
            this.comboBoxFunction.Size = new System.Drawing.Size(285, 21);
            this.comboBoxFunction.TabIndex = 50;
            this.comboBoxFunction.SelectedIndexChanged += new System.EventHandler(this.drawGraph);
            this.comboBoxFunction.Validated += new System.EventHandler(this.drawGraph);
            // 
            // label12
            // 
            this.label12.AutoSize = true;
            this.label12.Location = new System.Drawing.Point(9, 83);
            this.label12.Name = "label12";
            this.label12.Size = new System.Drawing.Size(68, 13);
            this.label12.TabIndex = 52;
            this.label12.Text = "Function of x";
            // 
            // progressBar
            // 
            this.progressBar.Anchor = System.Windows.Forms.AnchorStyles.Top;
            this.progressBar.Location = new System.Drawing.Point(213, 12);
            this.progressBar.Name = "progressBar";
            this.progressBar.Size = new System.Drawing.Size(623, 26);
            this.progressBar.Style = System.Windows.Forms.ProgressBarStyle.Marquee;
            this.progressBar.TabIndex = 55;
            // 
            // zedGraphControl
            // 
            this.zedGraphControl.Location = new System.Drawing.Point(330, 83);
            this.zedGraphControl.Name = "zedGraphControl";
            this.zedGraphControl.ScrollGrace = 0D;
            this.zedGraphControl.ScrollMaxX = 0D;
            this.zedGraphControl.ScrollMaxY = 0D;
            this.zedGraphControl.ScrollMaxY2 = 0D;
            this.zedGraphControl.ScrollMinX = 0D;
            this.zedGraphControl.ScrollMinY = 0D;
            this.zedGraphControl.ScrollMinY2 = 0D;
            this.zedGraphControl.Size = new System.Drawing.Size(506, 339);
            this.zedGraphControl.TabIndex = 67;
            // 
            // listBoxResults
            // 
            this.listBoxResults.FormattingEnabled = true;
            this.listBoxResults.Location = new System.Drawing.Point(12, 302);
            this.listBoxResults.Name = "listBoxResults";
            this.listBoxResults.Size = new System.Drawing.Size(285, 121);
            this.listBoxResults.TabIndex = 68;
            // 
            // label1
            // 
            this.label1.AutoSize = true;
            this.label1.Location = new System.Drawing.Point(12, 286);
            this.label1.Name = "label1";
            this.label1.Size = new System.Drawing.Size(42, 13);
            this.label1.TabIndex = 69;
            this.label1.Text = "Results";
            // 
            // Main
            // 
            this.AutoScaleDimensions = new System.Drawing.SizeF(6F, 13F);
            this.AutoScaleMode = System.Windows.Forms.AutoScaleMode.Font;
            this.ClientSize = new System.Drawing.Size(846, 518);
            this.Controls.Add(this.label1);
            this.Controls.Add(this.listBoxResults);
            this.Controls.Add(this.zedGraphControl);
            this.Controls.Add(this.progressBar);
            this.Controls.Add(this.label12);
            this.Controls.Add(this.comboBoxFunction);
            this.Controls.Add(this.numericIterations);
            this.Controls.Add(this.label11);
            this.Controls.Add(this.numericPopulationSize);
            this.Controls.Add(this.labelPopulationSize);
            this.Controls.Add(this.maxArgumentBox);
            this.Controls.Add(this.minArgumentBox);
            this.Controls.Add(this.labelRanges);
            this.Controls.Add(this.numericAccuracy);
            this.Controls.Add(this.numericMutate);
            this.Controls.Add(this.numericCrossover);
            this.Controls.Add(this.labelAccuracy);
            this.Controls.Add(this.labelMutate);
            this.Controls.Add(this.labelCrossover);
            this.Controls.Add(this.labelParameters);
            this.Controls.Add(this.start_button);
            this.Name = "Main";
            this.Text = "Softcomputing";
            ((System.ComponentModel.ISupportInitialize)(this.numericCrossover)).EndInit();
            ((System.ComponentModel.ISupportInitialize)(this.numericMutate)).EndInit();
            ((System.ComponentModel.ISupportInitialize)(this.numericAccuracy)).EndInit();
            ((System.ComponentModel.ISupportInitialize)(this.minArgumentBox)).EndInit();
            ((System.ComponentModel.ISupportInitialize)(this.maxArgumentBox)).EndInit();
            ((System.ComponentModel.ISupportInitialize)(this.numericPopulationSize)).EndInit();
            ((System.ComponentModel.ISupportInitialize)(this.numericIterations)).EndInit();
            this.ResumeLayout(false);
            this.PerformLayout();
        }
        #endregion
        private System.Windows.Forms.Button start_button;
        private System.Windows.Forms.Label labelParameters;
        private System.Windows.Forms.Label labelCrossover;
        private System.Windows.Forms.Label labelMutate;
        private System.Windows.Forms.Label labelAccuracy;
        private System.Windows.Forms.NumericUpDown numericCrossover;
        private System.Windows.Forms.NumericUpDown numericMutate;
        private System.Windows.Forms.NumericUpDown numericAccuracy;
        private System.Windows.Forms.Label labelRanges;
        private System.Windows.Forms.NumericUpDown minArgumentBox;
        private System.Windows.Forms.NumericUpDown maxArgumentBox;
        private System.Windows.Forms.Label labelPopulationSize;
        private System.Windows.Forms.NumericUpDown numericPopulationSize;
        private System.Windows.Forms.Label label11;
        private System.Windows.Forms.NumericUpDown numericIterations;
        private System.Windows.Forms.ComboBox comboBoxFunction;
        private System.Windows.Forms.Label label12;
        public System.Windows.Forms.ProgressBar progressBar;
        public ZedGraph.ZedGraphControl zedGraphControl;
        private System.Windows.Forms.ListBox listBoxResults;
        private System.Windows.Forms.Label label1;
    }
}
