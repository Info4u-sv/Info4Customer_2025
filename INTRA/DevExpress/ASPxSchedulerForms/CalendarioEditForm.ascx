<%@ Control Language="C#" AutoEventWireup="true" Inherits="CalendarioEditForm" Codebehind="CalendarioEditForm.ascx.cs" %>
<%@ Register Assembly="DevExpress.Web.ASPxHtmlEditor.v19.1, Version=19.1.6.0, Culture=neutral, PublicKeyToken=b88d1754d700e49a" Namespace="DevExpress.Web.ASPxHtmlEditor" TagPrefix="dx" %>
<%@ Register Assembly="DevExpress.Web.v19.1, Version=19.1.6.0, Culture=neutral, PublicKeyToken=b88d1754d700e49a" Namespace="DevExpress.Web" TagPrefix="dx" %>
<%@ Register Assembly="DevExpress.Web.ASPxScheduler.v19.1, Version=19.1.6.0, Culture=neutral, PublicKeyToken=b88d1754d700e49a" Namespace="DevExpress.Web.ASPxScheduler.Controls" TagPrefix="dxsc" %>
<%@ Register Assembly="DevExpress.Web.ASPxScheduler.v19.1, Version=19.1.6.0, Culture=neutral, PublicKeyToken=b88d1754d700e49a" Namespace="DevExpress.Web.ASPxScheduler" TagPrefix="dxwschs" %>

<div runat="server" id="ValidationContainer">
    <div class="row" style="overflow: initial !important">
                                                        <div class="col-lg-12 col-md-12 col-sm-12 col-xs-12" style="overflow: initial !important">
                                                            <div class="col-lg-12 col-md-12 col-sm-12 col-xs-12" style="padding-bottom: 20px">
                                                                <div class="form-group label-floating">
                                                                    <label class="control-label">Oggetto attività</label>
                                                                    <dx:BootstrapTextBox ID="OggettoAttivita_Txt" runat="server" Text='<%# Bind("OggettoAttivita") %>'>
                                                                        <validationsettings causesvalidation="true" requiredfield-isrequired="true" validationgroup="AttivitaValid" setfocusonerror="true"></validationsettings>
                                                                    </dx:BootstrapTextBox>
                                                                </div>
                                                            </div>
                                                            <div class="col-lg-12 col-md-12 col-sm-12 col-xs-12" style="padding-bottom: 20px">
                                                                <div class="col-lg-6 col-md-6 col-sm-6 col-xs-6" style="padding-left: 0px !important">
                                                                    <div class="form-group label-floating">
                                                                        <label class="control-label">Luogo attività</label>
                                                                        <dx:BootstrapTextBox ID="Luogo_Txt" runat="server" Text='<%# Bind("LuogoAttivita") %>'>
                                                                        </dx:BootstrapTextBox>
                                                                    </div>
                                                                </div>
                                                                <div class="col-lg-6 col-md-6 col-sm-6 col-xs-6" style="padding-left: 0px !important">
                                                                    <div class="form-group label-floating">
                                                                        <label class="control-label">Tipo attività</label>
                                                                        <dx:ASPxComboBox ID="TipoAttivita_Combo" ClientInstanceName="TipoAttivita_Combo" runat="server" ValueType="System.Int32" ValueField="id" TextField="Descrizione" DataSourceID="TipoAttivita_Sql" OnDataBound="TipoAttivita_Combo_DataBound">
                                                                            <ValidationSettings CausesValidation="true" RequiredField-IsRequired="true" ValidationGroup="AttivitaValid" SetFocusOnError="true"></ValidationSettings>
                                                                        </dx:ASPxComboBox>
                                                                        <asp:SqlDataSource ID="TipoAttivita_Sql" runat="server" ConnectionString='<%$ ConnectionStrings:info4portaleConnectionString %>' SelectCommand="SELECT id, Descrizione FROM CRM4U_TipoAttivita ORDER BY DisplayOrder"></asp:SqlDataSource>
                                                                    </div>
                                                                </div>
                                                            </div>
                                                            <div class="col-lg-12 col-md-12 col-sm-12 col-xs-12" style="overflow: initial !important; padding-bottom: 20px">
                                                                <div class="col-lg-6 col-md-6 col-sm-6 col-xs-6" style="padding-left: 0px !important">
                                                                    <div class="form-group label-floating">
                                                                        <label class="control-label">Data inizio attività</label>
                                                                        <dx:ASPxDateEdit ID="DataInizioAttivita_Date" runat="server" Date='<%# Eval("DataInizioAttivita") != null ? Eval("DataInizioAttivita") : DateTime.Now  %>'>

                                                                            <ValidationSettings CausesValidation="true" RequiredField-IsRequired="true" ValidationGroup="AttivitaValid" SetFocusOnError="true"></ValidationSettings>
                                                                        </dx:ASPxDateEdit>
                                                                    </div>
                                                                </div>
                                                                <div class="col-lg-6 col-md-6 col-sm-6 col-xs-6" style="overflow: initial !important; padding-left: 0px !important">
                                                                    <div class="form-group label-floating" style="overflow: initial !important">
                                                                        <label class="control-label">Ora inizio</label>
                                                                        <dx:ASPxTimeEdit ID="TempoInizioAttivita_Time" ClientInstanceName="TempoInizioAttivita_Time" runat="server" DateTime='<%# Eval("OraInizioAttivita") != null ? DateTime.Today.Add(TimeSpan.Parse(Eval("OraInizioAttivita").ToString())) : DateTime.Now  %>'>
                                                                            <ValidationSettings CausesValidation="true" RequiredField-IsRequired="true" ValidationGroup="AttivitaValid" SetFocusOnError="true"></ValidationSettings>
                                                                        </dx:ASPxTimeEdit>
                                                                    </div>
                                                                </div>
                                                            </div>
                                                            <div class="col-lg-12 col-md-12 col-sm-12 col-xs-12" style="overflow: initial !important; padding-bottom: 20px">
                                                                <div class="col-lg-6 col-md-6 col-sm-6 col-xs-6" style="overflow: initial !important; padding-left: 0px !important">
                                                                    <div class="form-group label-floating" style="overflow: initial !important">
                                                                        <label class="control-label">Data fine attività</label>
                                                                        <dx:ASPxDateEdit ID="DataFineAttivita_Date" runat="server" Date='<%# Eval("DataFineAttivita") != null ? Eval("DataFineAttivita") : DateTime.Now  %>'>
                                                                            <DateRangeSettings StartDateEditID="DataInizioAttivita_Date" />
                                                                            <ValidationSettings CausesValidation="true" RequiredField-IsRequired="true" ValidationGroup="AttivitaValid" SetFocusOnError="true"></ValidationSettings>
                                                                        </dx:ASPxDateEdit>
                                                                    </div>
                                                                </div>
                                                                <div class="col-lg-6 col-md-6 col-sm-6 col-xs-6" style="padding-left: 0px !important">
                                                                    <div class="form-group label-floating">
                                                                        <label class="control-label">Ora fine</label>
                                                                        <dx:ASPxTimeEdit ID="TempoFineAttivita_Time" ClientInstanceName="TempoFineAttivita_Time" runat="server" DateTime='<%# Eval("OraFineAttivita") != null ?  DateTime.Today.Add(TimeSpan.Parse(Eval("OraFineAttivita").ToString())) : DateTime.Now  %>'>
                                                                            <ValidationSettings CausesValidation="true" RequiredField-IsRequired="true" ValidationGroup="AttivitaValid" SetFocusOnError="true"></ValidationSettings>
                                                                        </dx:ASPxTimeEdit>
                                                                    </div>
                                                                </div>
                                                            </div>
                                                            <div class="col-lg-12 col-md-12 col-sm-12 col-xs-12" style="padding-bottom: 20px">
                                                                <div class="col-lg-6 col-md-6 col-sm-6 col-xs-6" style="padding-left: 0px !important">
                                                                    <div class="form-group label-floating">
                                                                        <label class="control-label">Status</label>
                                                                        <dx:ASPxComboBox ID="Status_Combobox" ClientInstanceName="Status_Combobox" runat="server" ValueType="System.String" DataSourceID="Status_Dts" ValueField="id" TextField="Descrizione" OnDataBound="Status_Combobox_DataBound">
                                                                            <ValidationSettings CausesValidation="true" RequiredField-IsRequired="true" ValidationGroup="AttivitaValid" SetFocusOnError="true"></ValidationSettings>
                                                                        </dx:ASPxComboBox>
                                                                        <asp:SqlDataSource ID="Status_Dts" runat="server" ConnectionString='<%$ ConnectionStrings:info4portaleConnectionString %>' SelectCommand="SELECT id, Descrizione FROM CRM4U_StatusAttivita ORDER BY DisplayOrder"></asp:SqlDataSource>
                                                                    </div>
                                                                </div>
                                                                <div class="col-lg-6 col-md-6 col-sm-6 col-xs-6" style="padding-left: 0px !important">
                                                                    <div class="form-group label-floating">
                                                                        <label class="control-label">Tutta la giornata</label>
                                                                        <dx:ASPxCheckBox ID="TuttaLagiornataAttivita_ckbx" ClientInstanceName="TuttaLagiornataAttivita_ckbx" runat="server">
                                                                            <ClientSideEvents CheckedChanged="function(s,e){
                                                                                            if(s.GetChecked()){
                                                                                            var currentdate1 = new Date();
                                                                                            var currentdate2 = new Date();
                                                                                            currentdate1.setHours(0);
                                                                                            currentdate1.setMinutes(0);
                                                                                            currentdate2.setHours(23);
                                                                                            currentdate2.setMinutes(59);
                                                                                            TempoInizioAttivita_Time.SetDate(currentdate1);
                                                                                            TempoInizioAttivita_Time.SetEnabled(false);
                                                                                            TempoFineAttivita_Time.SetDate(currentdate2);
                                                                                            TempoFineAttivita_Time.SetEnabled(false);
                                                                                            }
                                                                                            else{
                                                                                            TempoInizioAttivita_Time.SetEnabled(true);
                                                                                            TempoFineAttivita_Time.SetEnabled(true);}}" />
                                                                        </dx:ASPxCheckBox>
                                                                    </div>
                                                                </div>
                                                            </div>
                                                            <div class="col-lg-12 col-md-12 col-sm-12 col-xs-12" style="padding-bottom: 20px">
                                                                <div class="form-group label-floating">
                                                                    <label class="control-label">Descrizione attività</label>
                                                                    <dx:ASPxHtmlEditor ID="DescrizioneAttivita_Html" EncodeHtml="true" ClientInstanceName="DescrizioneAttivita_Html" Html='<%# Bind("DescrAttivita") %>' runat="server" Settings-AllowHtmlView="false" Settings-AllowPreview="false">
                                                                        <SettingsValidation RequiredField-IsRequired="true" ValidationGroup="AttivitaValid"></SettingsValidation>
                                                                    </dx:ASPxHtmlEditor>
                                                                </div>
                                                            </div>
                                                            <div class="col-lg-12 col-md-12 col-sm-12 col-xs-12" style="padding-bottom: 20px">
                                                                <div class="col-lg-6 col-md-6 col-sm-6 col-xs-6" style="padding-left: 0px !important">
                                                                    <div class="form-group label-floating">
                                                                        <label class="control-label">Remind</label>
                                                                        <dx:ASPxCheckBox ID="Remind_Ckbx" ClientInstanceName="Remind_Ckbx" runat="server" ClientEnabled='<%# Eval("RemindChkBox") == null ?  true : (Eval("RemindChkBox") == DBNull.Value ? true : (Convert.ToBoolean(Eval("RemindChkBox")) == true ? false : true)) %>' Checked='<%# Eval("RemindChkBox") != null ? ( Eval("RemindChkBox") == DBNull.Value ? false : (Convert.ToBoolean(Eval("RemindChkBox")) == true ? true : false)) : false %>'>
                                                                            <ClientSideEvents CheckedChanged="function(s,e){
                                                                            if(s.GetChecked())
                                                                                {
                                                                                Remind_CallbackPnl.SetVisible(true);
                                                                                Status_Combobox.SetSelectedIndex(3);
                                                                                }
                                                                            else
                                                                                {
                                                                                Remind_CallbackPnl.SetVisible(false);
                                                                                Status_Combobox.SetSelectedIndex(0);
                                                                                }
                                                                            }" />
                                                                        </dx:ASPxCheckBox>
                                                                    </div>
                                                                </div>
                                                                <div class="col-lg-6 col-md-6 col-sm-6 col-xs-6" style="padding-left: 0px !important">
                                                                    <div class="form-group label-floating">
                                                                        <label class="control-label">Aggiungi evento Exchange</label>
                                                                        <dx:ASPxCheckBox ID="Exchange_Ckbx" ClientInstanceName="Exchange_Ckbx" runat="server">
                                                                        </dx:ASPxCheckBox>
                                                                    </div>
                                                                </div>
                                                            </div>
                                                            <div class="col-lg-12 col-md-12 col-sm-12 col-xs-12" style="padding-bottom: 20px; padding-top: 20px">
                                                                <dx:ASPxCallbackPanel ID="Remind_CallbackPnl" ClientVisible="false" ClientInstanceName="Remind_CallbackPnl" runat="server" Width="100%">
                                                                    <PanelCollection>
                                                                        <dx:PanelContent>
                                                                            <div class="col-lg-12 col-md-12 col-sm-12 col-xs-12" style="padding-bottom: 20px">
                                                                                <div class="form-group label-floating">
                                                                                    <label class="control-label">Oggetto remind</label>
                                                                                    <dx:BootstrapTextBox ID="OggettoRemind_Txt" runat="server">
                                                                                        <validationsettings causesvalidation="true" requiredfield-isrequired="true" validationgroup="AttivitaRemindValid" setfocusonerror="true"></validationsettings>
                                                                                    </dx:BootstrapTextBox>
                                                                                </div>
                                                                            </div>
                                                                            <div class="col-lg-12 col-md-12 col-sm-12 col-xs-12" style="overflow: initial !important; padding-bottom: 20px">
                                                                                <div class="col-lg-6 col-md-6 col-sm-6 col-xs-6" style="overflow: initial !important; padding-left: 0px !important">
                                                                                    <div class="form-group label-floating" style="overflow: initial !important">
                                                                                        <label class="control-label">Luogo attività</label>
                                                                                        <dx:BootstrapTextBox ID="LuogoRemind_txt" runat="server">
                                                                                        </dx:BootstrapTextBox>
                                                                                    </div>
                                                                                </div>
                                                                                <div class="col-lg-6 col-md-6 col-sm-6 col-xs-6" style="overflow: initial !important; padding-left: 0px !important">
                                                                                    <div class="form-group label-floating">
                                                                                        <label class="control-label">Tipo attività remind</label>
                                                                                        <dx:ASPxComboBox ID="Tipoattivitaremind_Combobox" ClientInstanceName="Tipoattivitaremind_Combobox" runat="server" ValueType="System.Int32" ValueField="id" TextField="Descrizione" DataSourceID="TipoAttivita_Sql">
                                                                                            <ValidationSettings CausesValidation="true" RequiredField-IsRequired="true" ValidationGroup="AttivitaRemindValid" SetFocusOnError="true"></ValidationSettings>
                                                                                        </dx:ASPxComboBox>
                                                                                    </div>
                                                                                </div>
                                                                            </div>
                                                                            <div class="col-lg-12 col-md-12 col-sm-12 col-xs-12" style="overflow: initial !important; padding-bottom: 20px">
                                                                                <div class="col-lg-6 col-md-6 col-sm-6 col-xs-6" style="padding-left: 0px !important">
                                                                                    <div class="form-group label-floating">
                                                                                        <label class="control-label">Data inizio attività</label>
                                                                                        <dx:ASPxDateEdit ID="DataInizioRemind_Date" runat="server">
                                                                                            <ValidationSettings CausesValidation="true" RequiredField-IsRequired="true" ValidationGroup="AttivitaRemindValid" SetFocusOnError="true"></ValidationSettings>
                                                                                        </dx:ASPxDateEdit>
                                                                                    </div>
                                                                                </div>
                                                                                <div class="col-lg-6 col-md-6 col-sm-6 col-xs-6" style="overflow: initial !important; padding-left: 0px !important">
                                                                                    <div class="form-group label-floating" style="overflow: initial !important">
                                                                                        <label class="control-label">Ora inizio</label>
                                                                                        <dx:ASPxTimeEdit ID="OraInizioRemind_Time" ClientInstanceName="OraInizioRemind_Time" runat="server" DateTime='<%# Eval("OraInizioAttivita") != null ? DateTime.Today.Add(TimeSpan.Parse(Eval("OraInizioAttivita").ToString())) : DateTime.Now  %>'>
                                                                                            <ValidationSettings CausesValidation="true" RequiredField-IsRequired="true" ValidationGroup="AttivitaValid" SetFocusOnError="true"></ValidationSettings>
                                                                                        </dx:ASPxTimeEdit>
                                                                                    </div>
                                                                                </div>
                                                                            </div>
                                                                            <div class="col-lg-12 col-md-12 col-sm-12 col-xs-12" style="overflow: initial !important; padding-bottom: 20px">
                                                                                <div class="col-lg-6 col-md-6 col-sm-6 col-xs-6" style="overflow: initial !important; padding-left: 0px !important">
                                                                                    <div class="form-group label-floating" style="overflow: initial !important">
                                                                                        <label class="control-label">Data fine attività</label>
                                                                                        <dx:ASPxDateEdit ID="DataFineRemind_Date" runat="server">
                                                                                            <DateRangeSettings StartDateEditID="DataInizioRemind_Date" />
                                                                                            <ValidationSettings CausesValidation="true" RequiredField-IsRequired="true" ValidationGroup="AttivitaRemindValid" SetFocusOnError="true"></ValidationSettings>
                                                                                        </dx:ASPxDateEdit>
                                                                                    </div>
                                                                                </div>
                                                                                <div class="col-lg-6 col-md-6 col-sm-6 col-xs-6" style="padding-left: 0px !important">
                                                                                    <div class="form-group label-floating">
                                                                                        <label class="control-label">Ora fine</label>
                                                                                        <dx:ASPxTimeEdit ID="OraFineRemind_Time" ClientInstanceName="OraFineRemind_Time" runat="server" DateTime='<%# Eval("OraFineAttivita") != null ?  DateTime.Today.Add(TimeSpan.Parse(Eval("OraFineAttivita").ToString())) : DateTime.Now  %>'>
                                                                                            <ValidationSettings CausesValidation="true" RequiredField-IsRequired="true" ValidationGroup="AttivitaValid" SetFocusOnError="true"></ValidationSettings>
                                                                                        </dx:ASPxTimeEdit>
                                                                                    </div>
                                                                                    <div class="form-group label-floating">
                                                                                        <label class="control-label">Tutta la giornata</label>
                                                                                        <dx:ASPxCheckBox ID="Tuttalagiornata_Ckbx" ClientInstanceName="Tuttalagiornata_Ckbx" runat="server">
                                                                                            <ClientSideEvents CheckedChanged="function(s,e){
                                                                                            if(s.GetChecked()){
                                                                                            var currentdate1 = new Date();
                                                                                            var currentdate2 = new Date();
                                                                                            currentdate1.setHours(0);
                                                                                            currentdate1.setMinutes(0);
                                                                                            currentdate2.setHours(23);
                                                                                            currentdate2.setMinutes(59);
                                                                                            OraInizioRemind_Time.SetDate(currentdate1);OraInizioRemind_Time.SetEnabled(false);
                                                                                            OraFineRemind_Time.SetDate(currentdate2);OraFineRemind_Time.SetEnabled(false);
                                                                                            }
                                                                                            else{OraInizioRemind_Time.SetEnabled(true);OraFineRemind_Time.SetEnabled(true);}}" />
                                                                                        </dx:ASPxCheckBox>
                                                                                    </div>
                                                                                </div>
                                                                            </div>
                                                                            <div class="col-lg-12 col-md-12 col-sm-12 col-xs-12" style="overflow: initial !important; padding-bottom: 20px; padding-top: 20px">
                                                                                <div class="form-group label-floating" style="overflow: initial !important">
                                                                                    <label class="control-label">NOTE</label>
                                                                                    <dx:ASPxHtmlEditor ID="Noteremind_Html" ClientInstanceName="Noteremind_Html" runat="server" Settings-AllowHtmlView="false" Settings-AllowPreview="false">
                                                                                        <SettingsValidation RequiredField-IsRequired="true" ValidationGroup="AttivitaRemindValid">
                                                                                        </SettingsValidation>
                                                                                    </dx:ASPxHtmlEditor>
                                                                                </div>
                                                                            </div>
                                                                        </dx:PanelContent>
                                                                    </PanelCollection>
                                                                </dx:ASPxCallbackPanel>
                                                                <div class="col-lg-12 col-md-12 col-sm-12 col-xs-12" style="overflow: initial !important; padding-bottom: 20px">
                                                                    <dx:ASPxImage ID="Cancel_btn" ImageUrl="../img/DevExButton/cancel.png" Width="30px" runat="server">
                                                                        <ClientSideEvents Click="function(s,e){Attivita_GridView.CancelEdit();}" />
                                                                    </dx:ASPxImage>
                                                                    <dx:ASPxImage ID="Salva_Btn" ImageUrl="../img/DevExButton/save.png" Width="30px" runat="server">
                                                                        <ClientSideEvents Click="function(s,e){
                                                                            if(Remind_Ckbx.GetChecked()){
                                                                            if(ASPxClientEdit.ValidateGroup('AttivitaValid') && ASPxClientEdit.ValidateGroup('AttivitaRemindValid'))
                                                                            {
                                                                            Attivita_GridView.UpdateEdit();
                                                                            }
                                                                            }
                                                                            else{
                                                                            if(ASPxClientEdit.ValidateGroup('AttivitaValid'))
                                                                            {
                                                                            Attivita_GridView.UpdateEdit();
                                                                            }
                                                                            }
                                                                            }" />
                                                                    </dx:ASPxImage>
                                                                </div>
                                                            </div>
                                                        </div>
                                                    </div>
</div>
                        
<script id="dxss_ASPxSchedulerAppoinmentForm" type="text/javascript">
    ASPxAppointmentForm = ASPx.CreateClass(ASPxClientFormBase, {
    //    Initialize: function () {
    //        this.isValid = true;
    //        this.isRecurrenceValid = true;
    //        this.controls.edtStartDate.Validation.AddHandler(ASPx.CreateDelegate(this.OnEdtStartDateValidate, this));
    //        this.controls.edtEndDate.Validation.AddHandler(ASPx.CreateDelegate(this.OnEdtEndDateValidate, this));
    //        this.controls.edtStartDate.ValueChanged.AddHandler(ASPx.CreateDelegate(this.OnUpdateStartDateTimeValue, this));
    //        this.controls.edtEndDate.ValueChanged.AddHandler(ASPx.CreateDelegate(this.OnUpdateEndDateTimeValue, this));
    //        this.controls.edtStartTime.ValueChanged.AddHandler(ASPx.CreateDelegate(this.OnUpdateStartDateTimeValue, this));
    //        this.controls.edtEndTime.ValueChanged.AddHandler(ASPx.CreateDelegate(this.OnUpdateEndDateTimeValue, this));
    //        this.controls.chkAllDay.CheckedChanged.AddHandler(ASPx.CreateDelegate(this.OnChkAllDayCheckedChanged, this));
    //        this.controls.btnOk.Click.AddHandler(ASPx.CreateDelegate(this.OnBtnOk, this));
    //        if (this.controls.AppointmentRecurrenceForm1)
    //            this.controls.AppointmentRecurrenceForm1.ValidationCompleted.AddHandler(ASPx.CreateDelegate(this.OnRecurrenceRangeControlValidationCompleted, this));
    //        this.UpdateTimeEditorsVisibility();
    //        if (this.controls.chkReminder)
    //            this.controls.chkReminder.CheckedChanged.AddHandler(ASPx.CreateDelegate(this.OnChkReminderCheckedChanged, this));
    //        if (this.controls.edtMultiResource)
    //            this.controls.edtMultiResource.SelectedIndexChanged.AddHandler(ASPx.CreateDelegate(this.OnEdtMultiResourceSelectedIndexChanged, this));
    //        var start = this.controls.edtStartDate.GetValue();
    //        var end = this.controls.edtEndDate.GetValue();
    //        var duration = ASPxClientTimeInterval.CalculateDuration(start, end);
    //        this.appointmentInterval = new ASPxClientTimeInterval(start, duration);
    //        this.appointmentInterval.SetAllDay(this.controls.chkAllDay.GetValue());
    //        this.primaryIntervalJson = ASPx.Json.ToJson(this.appointmentInterval);
    //        this.UpdateDateTimeEditors();
    //    },
    //    OnBtnOk: function (s, e) {
    //        e.processOnServer = false;
    //        var formOwner = this.GetFormOwner();
    //        if (!formOwner)
    //            return;
    //        if (this.controls.AppointmentRecurrenceForm1 && this.IsRecurrenceChainRecreationNeeded() && this.cpHasExceptions) {
    //            formOwner.ShowMessageBox(this.localization.SchedulerLocalizer.Msg_Warning, this.localization.SchedulerLocalizer.Msg_RecurrenceExceptionsWillBeLost, this.OnWarningExceptionWillBeLostOk.aspxBind(this));
    //        } else {
    //            formOwner.AppointmentFormSave();
    //        }
    //    },
    //    IsRecurrenceChainRecreationNeeded: function () {
    //        var isIntervalChanged = this.primaryIntervalJson != ASPx.Json.ToJson(this.appointmentInterval);
    //        return isIntervalChanged || this.controls.AppointmentRecurrenceForm1.IsChanged();
    //    },
    //    OnWarningExceptionWillBeLostOk: function () {
    //        this.GetFormOwner().AppointmentFormSave();
    //    },
    //    OnEdtMultiResourceSelectedIndexChanged: function (s, e) {
    //        var resourceNames = new Array();
    //        var items = s.GetSelectedItems();
    //        var count = items.length;
    //        if (count > 0) {
    //            for (var i = 0; i < count; i++)
    //                resourceNames.push(items[i].text);
    //        }
    //        else
    //            resourceNames.push(ddResource.cp_Caption_ResourceNone);
    //        ddResource.SetValue(resourceNames.join(', '));
    //    },
    //    OnEdtStartDateValidate: function (s, e) {
    //        if (!e.isValid)
    //            return;
    //        var startDate = this.controls.edtStartDate.GetDate();
    //        var endDate = this.controls.edtEndDate.GetDate();
    //        e.isValid = startDate == null || endDate == null || startDate <= endDate;
    //        e.errorText = "The Start Date must precede the End Date.";
    //    },
    //    OnEdtEndDateValidate: function (s, e) {
    //        if (!e.isValid)
    //            return;
    //        var startDate = this.controls.edtStartDate.GetDate();
    //        var endDate = this.controls.edtEndDate.GetDate();
    //        e.isValid = startDate == null || endDate == null || startDate <= endDate;
    //        e.errorText = "The Start Date must precede the End Date.";
    //    },
    //    OnUpdateEndDateTimeValue: function (s, e) {
    //        var isAllDay = this.controls.chkAllDay.GetValue();
    //        var date = ASPxSchedulerDateTimeHelper.TruncToDate(this.controls.edtEndDate.GetDate());
    //        if (isAllDay)
    //            date = ASPxSchedulerDateTimeHelper.AddDays(date, 1);
    //        var time = ASPxSchedulerDateTimeHelper.ToDayTime(this.controls.edtEndTime.GetDate());
    //        var dateTime = ASPxSchedulerDateTimeHelper.AddTimeSpan(date, time);
    //        this.appointmentInterval.SetEnd(dateTime);
    //        this.UpdateDateTimeEditors();
    //        this.Validate();
    //    },
    //    OnUpdateStartDateTimeValue: function (s, e) {
    //        var date = ASPxSchedulerDateTimeHelper.TruncToDate(this.controls.edtStartDate.GetDate());
    //        var time = ASPxSchedulerDateTimeHelper.ToDayTime(this.controls.edtStartTime.GetDate());
    //        var dateTime = ASPxSchedulerDateTimeHelper.AddTimeSpan(date, time);
    //        this.appointmentInterval.SetStart(dateTime);
    //        this.UpdateDateTimeEditors();
    //        if (this.controls.AppointmentRecurrenceForm1)
    //            this.controls.AppointmentRecurrenceForm1.SetStart(dateTime);
    //        this.Validate();
    //    },
    //    OnChkReminderCheckedChanged: function (s, e) {
    //        var isReminderEnabled = this.controls.chkReminder.GetValue();
    //        if (isReminderEnabled)
    //            this.controls.cbReminder.SetSelectedIndex(3);
    //        else
    //            this.controls.cbReminder.SetSelectedIndex(-1);
    //        this.controls.cbReminder.SetEnabled(isReminderEnabled);
    //    },
    //    OnChkAllDayCheckedChanged: function (s, e) {
    //        this.UpdateTimeEditorsVisibility();
    //        var isAllDay = this.controls.chkAllDay.GetValue();
    //        this.appointmentInterval.SetAllDay(isAllDay);
    //        this.UpdateDateTimeEditors();
    //    },
    //    UpdateDateTimeEditors: function () {
    //        var isAllDay = this.controls.chkAllDay.GetValue();
    //        this.controls.edtStartDate.SetValue(this.appointmentInterval.GetStart());
    //        var end = this.appointmentInterval.GetEnd();
    //        if (isAllDay) {
    //            end = ASPxSchedulerDateTimeHelper.AddDays(end, -1);
    //        }
    //        this.controls.edtEndDate.SetValue(end);
    //        this.controls.edtStartTime.SetValue(this.appointmentInterval.GetStart());
    //        this.controls.edtEndTime.SetValue(end);
    //    },
    //    UpdateTimeEditorsVisibility: function () {
    //        var isAllDay = this.controls.chkAllDay.GetValue();
    //        var visible = (isAllDay) ? "none" : "";
    //        var startRoot = ASPx.GetParentById(this.controls.edtStartTime.GetMainElement(), "edtStartTimeLayoutRoot");
    //        var endRoot = ASPx.GetParentById(this.controls.edtEndTime.GetMainElement(), "edtEndTimeLayoutRoot");
    //        startRoot.style.display = visible;
    //        endRoot.style.display = visible;
    //    },
    //    Validate: function () {
    //        this.isValid = ASPxClientEdit.ValidateEditorsInContainer(null);
    //        this.controls.btnOk.SetEnabled(this.isValid && this.isRecurrenceValid);
    //    },
    //    OnRecurrenceRangeControlValidationCompleted: function (s, e) {
    //        if (!this.controls.AppointmentRecurrenceForm1)
    //            return;
    //        this.isRecurrenceValid = this.controls.AppointmentRecurrenceForm1.IsValid();
    //        this.controls.btnOk.SetEnabled(this.isValid && this.isRecurrenceValid);
    //    }
    });
</script>