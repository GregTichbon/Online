namespace SMSChecker
{
    partial class ProjectInstaller
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

        #region Component Designer generated code

        /// <summary>
        /// Required method for Designer support - do not modify
        /// the contents of this method with the code editor.
        /// </summary>
        private void InitializeComponent()
        {
            this.SMSCheckerInstaller = new System.ServiceProcess.ServiceProcessInstaller();
            this.SMSCheckerService = new System.ServiceProcess.ServiceInstaller();
            // 
            // SMSCheckerInstaller
            // 
            this.SMSCheckerInstaller.Account = System.ServiceProcess.ServiceAccount.LocalSystem;
            this.SMSCheckerInstaller.Password = null;
            this.SMSCheckerInstaller.Username = null;
            this.SMSCheckerInstaller.AfterInstall += new System.Configuration.Install.InstallEventHandler(this.serviceProcessInstaller1_AfterInstall);
            // 
            // SMSCheckerService
            // 
            this.SMSCheckerService.ServiceName = "SMSCheckerService";
            this.SMSCheckerService.StartType = System.ServiceProcess.ServiceStartMode.Automatic;
            this.SMSCheckerService.AfterInstall += new System.Configuration.Install.InstallEventHandler(this.SMSCheckerService_AfterInstall);
            // 
            // ProjectInstaller
            // 
            this.Installers.AddRange(new System.Configuration.Install.Installer[] {
            this.SMSCheckerInstaller,
            this.SMSCheckerService});

        }

        #endregion

        private System.ServiceProcess.ServiceProcessInstaller SMSCheckerInstaller;
        private System.ServiceProcess.ServiceInstaller SMSCheckerService;
    }
}