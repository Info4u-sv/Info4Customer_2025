<%--
{************************************************************************************}
{                                                                                    }
{   DO NOT MODIFY THIS FILE!                                                         }
{                                                                                    }
{   It will be overwritten without prompting when a new version becomes              }
{   available. All your changes will be lost.                                        }
{                                                                                    }
{   This file contains the default template and is required for the appointment      }
{   rendering. Improper modifications may result in incorrect appearance of the      }
{   appointment.                                                                     }
{                                                                                    }
{   In order to create and use your own custom template, perform the following       }
{   steps:                                                                           }
{       1. Save a copy of this file with a different name in another location.       }
{       2. Add a Register tag in the .aspx page header for each template you use,    }
{          as follows: <%@ Register Src="PathToTemplateFile" TagName="NameOfTemplate"}
{          TagPrefix="ShortNameOfTemplate" %>                                        }
{       3. In the .aspx page find the tags for different scheduler views within      }
{          the ASPxScheduler control tag. Insert template tags into the tags         }
{          for the views which should be customized.                                 }
{          The template tag should satisfy the following pattern:                    }
{          <Templates>                                                               }
{              <HorizontalAppointmentTemplate>                                       }
{                  < ShortNameOfTemplate: NameOfTemplate runat="server"/>            }
{              </HorizontalAppointmentTemplate>                                      }
{          </Templates>                                                              }
{          where ShortNameOfTemplate, NameOfTemplate are the names of the            }
{          registered templates, defined in step 2.                                  }
{************************************************************************************}
--%>
<%@ Control Language="C#" AutoEventWireup="true" Inherits="HorizontalAppointmentTemplate" Codebehind="HorizontalAppointmentTemplate.ascx.cs" %>

<%@ Register Assembly="DevExpress.Web.ASPxScheduler.v24.2, Version=24.2.6.0, Culture=neutral, PublicKeyToken=b88d1754d700e49a" Namespace="DevExpress.Web.ASPxScheduler" TagPrefix="dxwschs" %>
<%@ Register Assembly="DevExpress.Web.v24.2, Version=24.2.6.0, Culture=neutral, PublicKeyToken=b88d1754d700e49a" Namespace="DevExpress.Web" TagPrefix="dx" %>

<div id="appointmentDiv" runat="server" class="dxsc-apt-wrapper dxsc-horizontal-apt">
    <div id="statusBack" runat="server" class="dxsc-apt-status-container">
        <div id="statusFore" runat="server" class="dxsc-apt-status"></div>
    </div>

    <div class="dxsc-apt-container">
        <div class="dxsc-apt-intermediate-bg"></div>
        <div class="dxsc-apt-bg" runat="server" id="appointmentBackground"></div>
        <div class="dxsc-apt-gradient"></div>
        <div class="dxsc-apt-custom-background" runat="server" id="customBackgroundLayer"></div>
        <div class="dxsc-apt-content-layer">
            <div class="dxsc-content-wrapper">
                <div class="dxsc-apt-left-container">
                    <asp:Image runat="server" ID="imgStartContinueArrow" Visible='<%#((HorizontalAppointmentTemplateContainer)Container).Items.StartContinueArrow.Visible%>'></asp:Image>
                    <dx:ASPxLabel runat="server" EnableViewState="false" EncodeHtml="true" ID="lblStartContinueText" Text='<%#((HorizontalAppointmentTemplateContainer)Container).Items.StartContinueText.Text%>' Visible='<%#((HorizontalAppointmentTemplateContainer)Container).Items.StartContinueText.Visible%>'></dx:ASPxLabel>
                    <div runat="server" id="startTimeClockContainer" class="dxsc-apt-clock-container"></div>
                    <div class="dxsc-apt-time-container">
                        <dx:ASPxLabel runat="server" EnableViewState="false" EncodeHtml="true" ID="lblStartTime" Text='<%#((HorizontalAppointmentTemplateContainer)Container).Items.StartTimeText.Text%>' Visible='<%#((HorizontalAppointmentTemplateContainer)Container).Items.StartTimeText.Visible%>'></dx:ASPxLabel>
                    </div>
                </div>
                <div class="dxsc-apt-right-container">
                    <div runat="server" id="endTimeClockContainer" class="dxsc-apt-clock-container"></div>
                    <div class="dxsc-apt-time-container">
                        <dx:ASPxLabel runat="server" EnableViewState="false" EncodeHtml="true" ID="lblEndTime" Text='<%#((HorizontalAppointmentTemplateContainer)Container).Items.EndTimeText.Text%>' Visible='<%#((HorizontalAppointmentTemplateContainer)Container).Items.EndTimeText.Visible%>'></dx:ASPxLabel>
                    </div>
                    <dx:ASPxLabel runat="server" EnableViewState="false" EncodeHtml="true" ID="lblEndContinueText" Text='<%#((HorizontalAppointmentTemplateContainer)Container).Items.EndContinueText.Text%>' Visible='<%#((HorizontalAppointmentTemplateContainer)Container).Items.EndContinueText.Visible%>'></dx:ASPxLabel>
                    <asp:Image runat="server" ID="imgEndContinueArrow" Visible='<%#((HorizontalAppointmentTemplateContainer)Container).Items.EndContinueArrow.Visible%>'></asp:Image>
                </div>
                <div class="dxsc-apt-center-container">
                    <div id="imageContainer" runat="server" class="dxsc-apt-images-container"></div>
                    <dx:ASPxLabel runat="server" EnableViewState="false" EncodeHtml="true" ID="lblTitle" Text='<%#((HorizontalAppointmentTemplateContainer)Container).Items.Title.Text%>'></dx:ASPxLabel>
                </div>
            </div>
        </div>
    </div>
</div>