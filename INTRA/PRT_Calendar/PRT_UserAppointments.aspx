<%@ Page Title="" Language="C#" MasterPageFile="~/Site.Master" AutoEventWireup="true" CodeBehind="PRT_UserAppointments.aspx.cs" Inherits="INTRA.PRT_Calendar.PRT_UserAppointments" %>

<%@ Register Assembly="DevExpress.Web.ASPxScheduler.v24.2, Version=24.2.6.0, Culture=neutral, PublicKeyToken=b88d1754d700e49a" Namespace="DevExpress.Web.ASPxScheduler" TagPrefix="dx" %>

<%@ Register Assembly="DevExpress.XtraScheduler.v24.2.Core, Version=24.2.6.0, Culture=neutral, PublicKeyToken=b88d1754d700e49a" Namespace="DevExpress.XtraScheduler" TagPrefix="cc1" %>
<%@ Register Assembly="DevExpress.XtraScheduler.v24.2.Core.Desktop, Version=24.2.6.0, Culture=neutral, PublicKeyToken=b88d1754d700e49a" Namespace="DevExpress.XtraScheduler" TagPrefix="cc1" %>

<asp:Content ID="Content1" ContentPlaceHolderID="RootHolder" runat="server">
</asp:Content>
<asp:Content ID="Content2" ContentPlaceHolderID="MainContent" runat="server">
    <div class="row">
        <div class="col-lg-12">
            <div class="card">
                <div class="card-header">
                    <div class="row">
                        <div class="col-lg-12">

                            <dx:ASPxScheduler ID="ASPxScheduler1" runat="server" Width="100%" ActiveViewType="Day" AppointmentDataSourceID="AppointmentDataSource" ResourceDataSourceID="efResourceDataSource"
                                GroupType="Resource" ClientInstanceName="ASPxClientScheduler1">
                                <Views>
                                    <DayView ResourcesPerPage="2">
                                        <WorkTime Start="07:00:00" End="20:00:00" />
                                    </DayView>
                                    <WorkWeekView Enabled="false" />
                                    <WeekView Enabled="false" />
                                    <MonthView Enabled="false" />
                                    <TimelineView Enabled="false" />
                                    <AgendaView Enabled="false" />
                                </Views>
                                <OptionsBehavior ShowViewSelector="false" />
                                <Storage EnableReminders="false" />
                            </dx:ASPxScheduler>
                            <demo:schedulerdemodatasource runat="server" id="AppointmentDataSource" datasourceid="efAppointmentDataSource" issitemode="True"></demo:schedulerdemodatasource>
                            <ef:entitydatasource id="efAppointmentDataSource" runat="server" contexttypename="DevExpress.Web.Demos.MedicsSchedulingDBContext" entitysetname="MedicalAppointments"
                                enableinsert="true" enableupdate="true" enabledelete="true" enableflattening="false" />
                            <ef:entitydatasource id="efResourceDataSource" runat="server" contexttypename="DevExpress.Web.Demos.MedicsSchedulingDBContext" entitysetname="Medics" enableflattening="false" />

                            <dx:ASPxFormLayout ID="OptionsFormLayout" runat="server">
                                <Items>
                                    <dx:LayoutGroup Caption="Appointment Layout">
                                        <Items>
                                            <dx:LayoutItem Caption="Snap To Cells Mode">
                                                <LayoutItemNestedControlCollection>
                                                    <dx:LayoutItemNestedControlContainer>
                                                        <dx:ASPxComboBox ID="cbSnapToCellsMode" runat="server" SelectedIndex="0" ValueType="System.Int32">
                                                            <ClientSideEvents SelectedIndexChanged="function(s, e) { ASPxClientScheduler1.Refresh(); }" />
                                                            <Items>
                                                                <dx:ListEditItem Text="Auto" Value="0" />
                                                                <dx:ListEditItem Text="Always" Value="1" />
                                                                <dx:ListEditItem Text="Never" Value="2" />
                                                            </Items>
                                                        </dx:ASPxComboBox>
                                                    </dx:LayoutItemNestedControlContainer>
                                                </LayoutItemNestedControlCollection>
                                            </dx:LayoutItem>
                                            <dx:LayoutItem Caption="Start Time Visibility">
                                                <LayoutItemNestedControlCollection>
                                                    <dx:LayoutItemNestedControlContainer>
                                                        <dx:ASPxComboBox ID="cbStartTimeVisibility" runat="server" SelectedIndex="0" ValueType="System.Int32">
                                                            <ClientSideEvents SelectedIndexChanged="function(s, e) { ASPxClientScheduler1.Refresh(); }" />
                                                            <Items>
                                                                <dx:ListEditItem Text="Auto" Value="0" />
                                                                <dx:ListEditItem Text="Always" Value="1" />
                                                                <dx:ListEditItem Text="Never" Value="2" />
                                                            </Items>
                                                        </dx:ASPxComboBox>
                                                    </dx:LayoutItemNestedControlContainer>
                                                </LayoutItemNestedControlCollection>
                                            </dx:LayoutItem>
                                            <dx:LayoutItem Caption="End Time Visibility">
                                                <LayoutItemNestedControlCollection>
                                                    <dx:LayoutItemNestedControlContainer>
                                                        <dx:ASPxComboBox ID="cbEndTimeVisibility" runat="server" SelectedIndex="0" ValueType="System.Int32">
                                                            <ClientSideEvents SelectedIndexChanged="function(s, e) { ASPxClientScheduler1.Refresh(); }" />
                                                            <Items>
                                                                <dx:ListEditItem Text="Auto" Value="0" />
                                                                <dx:ListEditItem Text="Always" Value="1" />
                                                                <dx:ListEditItem Text="Never" Value="2" />
                                                            </Items>
                                                        </dx:ASPxComboBox>
                                                    </dx:LayoutItemNestedControlContainer>
                                                </LayoutItemNestedControlCollection>
                                            </dx:LayoutItem>
                                            <dx:LayoutItem Caption="Show Recurrence">
                                                <LayoutItemNestedControlCollection>
                                                    <dx:LayoutItemNestedControlContainer>
                                                        <dx:ASPxCheckBox ID="cbShowRecurrence" runat="server" Checked="True">
                                                            <ClientSideEvents CheckedChanged="function(s, e) { ASPxClientScheduler1.Refresh(); }" />
                                                        </dx:ASPxCheckBox>
                                                    </dx:LayoutItemNestedControlContainer>
                                                </LayoutItemNestedControlCollection>
                                            </dx:LayoutItem>
                                        </Items>
                                    </dx:LayoutGroup>
                                    <dx:LayoutGroup Caption="View Layout options">
                                        <Items>
                                            <dx:LayoutItem Caption="Day Count">
                                                <LayoutItemNestedControlCollection>
                                                    <dx:LayoutItemNestedControlContainer>
                                                        <dx:ASPxComboBox ID="cbDayCount" runat="server" ValueType="System.Int32" SelectedIndex="2">
                                                            <ClientSideEvents SelectedIndexChanged="function(s, e) { ASPxClientScheduler1.Refresh(); }" />
                                                            <Items>
                                                                <dx:ListEditItem Text="1" Value="1" />
                                                                <dx:ListEditItem Text="2" Value="2" />
                                                                <dx:ListEditItem Text="3" Value="3" />
                                                                <dx:ListEditItem Text="4" Value="4" />
                                                                <dx:ListEditItem Text="5" Value="5" />
                                                                <dx:ListEditItem Text="6" Value="6" />
                                                                <dx:ListEditItem Text="7" Value="7" />
                                                                <dx:ListEditItem Text="8" Value="8" />
                                                                <dx:ListEditItem Text="9" Value="9" />
                                                                <dx:ListEditItem Text="10" Value="10" />
                                                            </Items>
                                                        </dx:ASPxComboBox>
                                                    </dx:LayoutItemNestedControlContainer>
                                                </LayoutItemNestedControlCollection>
                                            </dx:LayoutItem>
                                            <dx:LayoutItem Caption="Show All Day Area">
                                                <LayoutItemNestedControlCollection>
                                                    <dx:LayoutItemNestedControlContainer>
                                                        <dx:ASPxCheckBox ID="chkShowAllDayArea" runat="server" Checked="True">
                                                            <ClientSideEvents CheckedChanged="function(s, e) { ASPxClientScheduler1.Refresh(); }" />
                                                        </dx:ASPxCheckBox>
                                                    </dx:LayoutItemNestedControlContainer>
                                                </LayoutItemNestedControlCollection>
                                            </dx:LayoutItem>
                                            <dx:LayoutItem Caption="Show Day Headers">
                                                <LayoutItemNestedControlCollection>
                                                    <dx:LayoutItemNestedControlContainer runat="server" SupportsDisabledAttribute="True">
                                                        <dx:ASPxCheckBox ID="chkShowDayHeaders" runat="server" Checked="True">
                                                            <ClientSideEvents CheckedChanged="function(s, e) { ASPxClientScheduler1.Refresh(); }" />
                                                        </dx:ASPxCheckBox>
                                                    </dx:LayoutItemNestedControlContainer>
                                                </LayoutItemNestedControlCollection>
                                            </dx:LayoutItem>
                                            <dx:LayoutItem Caption="Show Work Time Only">
                                                <LayoutItemNestedControlCollection>
                                                    <dx:LayoutItemNestedControlContainer runat="server" SupportsDisabledAttribute="True">
                                                        <dx:ASPxCheckBox ID="chkShowWorkTimeOnly" runat="server" Checked="true">
                                                            <ClientSideEvents CheckedChanged="function(s, e) { ASPxClientScheduler1.Refresh(); }" />
                                                        </dx:ASPxCheckBox>
                                                    </dx:LayoutItemNestedControlContainer>
                                                </LayoutItemNestedControlCollection>
                                            </dx:LayoutItem>
                                        </Items>
                                    </dx:LayoutGroup>
                                    <dx:LayoutGroup Caption="Common options">
                                        <Items>
                                            <dx:LayoutItem Caption="AppointmentSelection Appearance Mode">
                                                <LayoutItemNestedControlCollection>
                                                    <dx:LayoutItemNestedControlContainer>
                                                        <dx:ASPxComboBox ID="SelectionAppearanceModeComboBox" runat="server" SelectedIndex="0" ValueType="System.Int32">
                                                            <ClientSideEvents SelectedIndexChanged="function(s, e) { ASPxClientScheduler1.Refresh(); }" />
                                                            <Items>
                                                                <dx:ListEditItem Text="Auto" Value="0" />
                                                                <dx:ListEditItem Text="BackgroundOpacity" Value="1" />
                                                                <dx:ListEditItem Text="BoundaryFrame" Value="2" />
                                                            </Items>
                                                        </dx:ASPxComboBox>
                                                    </dx:LayoutItemNestedControlContainer>
                                                </LayoutItemNestedControlCollection>
                                            </dx:LayoutItem>
                                            <dx:LayoutItem Caption="Show View Navigator">
                                                <LayoutItemNestedControlCollection>
                                                    <dx:LayoutItemNestedControlContainer>
                                                        <dx:ASPxCheckBox ID="ShowViewNavigatorCheckBox" runat="server" Checked="true">
                                                            <ClientSideEvents CheckedChanged="function(s, e) { ASPxClientScheduler1.Refresh(); }" />
                                                        </dx:ASPxCheckBox>
                                                    </dx:LayoutItemNestedControlContainer>
                                                </LayoutItemNestedControlCollection>
                                            </dx:LayoutItem>
                                            <dx:LayoutItem Caption="Show View Visible Interval">
                                                <LayoutItemNestedControlCollection>
                                                    <dx:LayoutItemNestedControlContainer>
                                                        <dx:ASPxCheckBox ID="ShowViewVisibleIntervalCheckBox" runat="server" Checked="true">
                                                            <ClientSideEvents CheckedChanged="function(s, e) { ASPxClientScheduler1.Refresh(); }" />
                                                        </dx:ASPxCheckBox>
                                                    </dx:LayoutItemNestedControlContainer>
                                                </LayoutItemNestedControlCollection>
                                            </dx:LayoutItem>
                                            <dx:LayoutItem Caption="Highlight Selection Headers">
                                                <LayoutItemNestedControlCollection>
                                                    <dx:LayoutItemNestedControlContainer>
                                                        <dx:ASPxCheckBox ID="HighlightSelectionCheckBox" runat="server" Checked="true">
                                                            <ClientSideEvents CheckedChanged="function(s, e) { ASPxClientScheduler1.Refresh(); }" />
                                                        </dx:ASPxCheckBox>
                                                    </dx:LayoutItemNestedControlContainer>
                                                </LayoutItemNestedControlCollection>
                                            </dx:LayoutItem>
                                        </Items>
                                    </dx:LayoutGroup>
                                </Items>
                            </dx:ASPxFormLayout>
                        </div>
                    </div>
                </div>
            </div>
        </div>
    </div>
</asp:Content>
<asp:Content ID="Content3" ContentPlaceHolderID="PageScriptContent" runat="server">
</asp:Content>
