<%@ Page Title="" Language="C#" MasterPageFile="~/Site.Master" AutoEventWireup="true" CodeBehind="TestGrafici_DevExtreme.aspx.cs" Inherits="INTRA.DevExtreme_Dashboard.TestGrafici_DevExtreme" %>

<asp:Content ID="Content1" ContentPlaceHolderID="RootHolder" runat="server">
        <style type="text/css">
        html, body, form {
            margin: 0;
            padding: 0;
        }
    </style>
    
    <script type="text/javascript" src="../assets/DevExtreme/js/jquery.min.js"></script>
    <script src="../assets/DevExtreme/js/cldr.min.js"></script>
    <script src="../assets/DevExtreme/js/cldr/event.min.js"></script>
    <script src="../assets/DevExtreme/js/cldr/supplemental.min.js"></script>  

    <script type="text/javascript" src="../assets/DevExtreme/js/dx.all.js"></script>
    <script src="https://unpkg.com/devextreme-aspnet-data/js/dx.aspnet.data.js"></script>
    
    <script type="text/javascript">
            $(function () {
                $("#chartContainer").dxChart({
                    dataSource: chartData,
                    commonSeriesSettings: {
                        argumentField: 'PlatformName',
                        type: 'bar'
                    },
                    series: [
                        { valueField: 'Count' }
                    ]
                });
            });
        </script>

    <script>
        $(() => {
            $('#chart').dxChart({
                rotated: true,
                dataSource: 'data/simpleJSON.json',
                series: {
                    label: {
                        visible: true,
                        backgroundColor: '#c18e92',
                    },
                    color: '#79cac4',
                    type: 'bar',
                    argumentField: 'day',
                    valueField: 'sales',
                },
                title: 'Daily Sales',
                argumentAxis: {
                    label: {
                        customizeText() {
                            return `Day ${this.valueText}`;
                        },
                    },
                },
                valueAxis: {
                    tick: {
                        visible: false,
                    },
                    label: {
                        visible: false,
                    },
                },
                export: {
                    enabled: true,
                },
                legend: {
                    visible: false,
                },
            });
        });
    </script>

    <script>
        $(() => {
            const serviceUrl = "http://192.168.156.78:9988/WebService_primo.asmx";


            //$('#pie').dxPieChart({
            //    type: 'doughnut',
            //    palette: 'Soft Pastel',
            //    dataSource: DevExpress.data.AspNet.createStore({
            //        key: 'ID',
            //        loadUrl: serviceUrl + "/GetOfferteKingStat_Grouped"
            //    }),
            //    title: 'The Population of Continents and Regions',
            //    tooltip: {
            //        enabled: true,
            //        format: 'millions',
            //        customizeTooltip(arg) {
            //            return {
            //                text: `${arg.valueText} - ${(arg.percent * 100).toFixed(2)}%`,
            //            };
            //        },
            //    },
            //    legend: {
            //        horizontalAlignment: 'right',
            //        verticalAlignment: 'top',
            //        margin: 0,
            //    },
            //    export: {
            //        enabled: true,
            //    },
            //    series: [{
            //        argumentField: 'region',
            //        label: {
            //            visible: true,
            //            format: 'millions',
            //            connector: {
            //                visible: true,
            //            },
            //        },
            //    }],
            //});
            const populationData = [{
                name: 'California',
                population: 38802500,
                TotA: 'Sacramento',
                area: 423967,
            }, {
                name: 'Texas',
                population: 26956958,
                capital: 'Austin',
                area: 695662,
            }, {
                name: 'Florida',
                population: 19893297,
                capital: 'Tallahassee',
                area: 170312,
            }, {
                name: 'New York',
                population: 19746227,
                capital: 'Albany',
                area: 141297,
            }, {
                name: 'Illinois',
                population: 12880580,
                capital: 'Springfield',
                area: 149995,
            }];
            var dts = DevExpress.data.AspNet.createStore({
                key: 'ID',
                loadUrl: serviceUrl + "/GetOfferteKingStat_Grouped?Anno=1900"
            });
            $('#chartWebService').dxChart({
                rotated: false,
                dataSource: dts,
                commonSeriesSettings: {
                    argumentField: 'Anno',
                    type: 'stackedBar',
                    //customizeText(arg) {
                    //    return `${arg.argumentText} - ${arg.valueText}`;
                    //},
                },
                series: [
                    { valueField: 'Gennaio', name: 'Gennaio', valueText: 'TotaleAnno' },
                    { valueField: 'Febbraio', name: 'Febbraio', valueText: 'TotaleAnno' },
                    { valueField: 'Marzo', name: 'Marzo', valueText: 'TotaleAnno' },
                    { valueField: 'Aprile', name: 'Aprile', valueText: 'TotaleAnno' },
                    { valueField: 'Maggio', name: 'Maggio', valueText: 'TotaleAnno' },
                    { valueField: 'Giugno', name: 'Giugno', valueText: 'TotaleAnno' },
                    { valueField: 'Luglio', name: 'Luglio', valueText: 'TotaleAnno' },
                    { valueField: 'Agosto', name: 'Agosto', valueText: 'TotaleAnno' },
                    { valueField: 'Settembre', name: 'Settembre', valueText: 'TotaleAnno' },
                    { valueField: 'Ottobre', name: 'Ottobre', valueText: 'TotaleAnno' },
                    { valueField: 'Novembre', name: 'Novembre', valueText: 'TotaleAnno' },
                    { valueField: 'Dicembre', name: 'Dicembre', valueText: 'TotaleAnno' },
                    { valueField: 'TotaleAnno', name: 'TotaleAnno', valueText: 'TotaleAnno' },
        
                   
                    //color: '#79cac4',
                    //type: 'bar',
                    //argumentField: 'Anno',
                    //valueField: 'TotOfferte',
                ], label: {
                    visible: true,
                    backgroundColor: '#c18e92',
                },
                title: 'Test WebService',

                tooltip: {
                    enabled: true,
                    location: 'edge',
                    customizeTooltip(arg) {
                        return {
                            text: `${arg.seriesName} Totale: ${arg.valueText} /Tot. Anno: ${arg.valueText} `,
                        };
                    },
                },
                argumentAxis: {
                    tickInterval: 1,
                    label: {
                        format: {
                            type: 'decimal',
                        },
                        customizeText() {
                            return `Anno ${this.valueText}`;
                        },
                    },
                },
                valueAxis: {
                    title: {
                        text: 'Tot Offerte',
                    },
                    autoBreaksEnabled: true,
                    position: 'right',
                },
                export: {
                    enabled: true,
                },
                legend: {
                    visible: true,
                    verticalAlignment: 'bottom',
                    horizontalAlignment: 'center',
                    itemTextPosition: 'top',
                },
                commonAnnotationSettings: {
                    type: 'custom',
                    /*series: 'Population',*/
                    allowDragging: true,
                    template(annotation, container) {
                        const { data } = annotation;
                        const contentItems = ["<svg class='annotation'>",
                            "<image href='images/flags/",
                            data.name.replace(/\s/, '').toLowerCase(), ".svg' width='60' height='40' />",
                            "<rect class='border' x='0' y='0' />",
                            "<text x='70' y='25' class='state'/>",
                            "<text x='0' y='60'>",
                            "<tspan class='caption'>Capital:</tspan>",
                            "<tspan class='capital' dx='5'/>",
                            "<tspan dy='14' x='0' class='caption'>Population:</tspan>",
                            "<tspan class='population' dx='5'/>",
                            "<tspan dy='14' x='0' class='caption'>Area:</tspan>",
                            "<tspan class='area' dx='5'/>",
                            "<tspan dx='5'>km</tspan><tspan dy='-2' class='sup'>2</tspan>",
                            '</text></svg>'];

                        const content = $(contentItems.join(''));

                        content.find('.state').text(annotation.argument);
                        content.find('.capital').text(data.TotaleAnno);
                        content.find('.population').text(formatNumber(data.TotaleAnno));
                        content.find('.area').text(formatNumber(data.TotaleAnno));

                        content.appendTo(container);
                    },
                },
                annotations: $.map(populationData, (data) => ({
                    argument: data.name,
                    data,
                })),
            });
        });
    </script>

    <script>
        $(() => {
            const serviceUrl = "http://192.168.156.78:9988/WebService_primo.asmx";
            var dts = DevExpress.data.AspNet.createStore({
                key: 'ID',
                loadUrl: serviceUrl + "/GetOfferteKingStat?Anno=2021"
            });

            function GetMonthName(value) {
                return dts.filter((item) => item.TotOfferta === value);
            }
            $('#pie').dxPieChart({
                type: 'doughnut',
                palette: 'Soft Pastel',
                dataSource: dts,
                //commonSeriesSettings: {
                //    argumentField: 'Mese',
                //},
                title: 'The Population of Continents and Regions',
                tooltip: {
                    enabled: true,
                    customizeTooltip(arg) {
                        return {
                            text: ` ${arg.argumentText} - ${arg.valueText}`,
                        };
                    },
                },
                legend: {
                    horizontalAlignment: 'right',
                    verticalAlignment: 'top',
                    margin: 0,
                },
                export: {
                    enabled: true,
                },
                series: [
                    {
                        argumentField: 'MeseText',
                        /*valueText: 'MeseText',*/
                        valueField: 'TotOfferte',
                        //label: {
                        //    visible: true,
                        //    connector: {
                        //        visible: true,
                        //        width: 1,
                        //    },
                        //},

                        label: {
                            visible: true,
                            customizeText(arg) {
                                return `${arg.argumentText} - ${arg.valueText}`;
                            },
                        },


                    },
                ],
            });
        });
    </script>
</asp:Content>
<asp:Content ID="Content2" ContentPlaceHolderID="MainContent" runat="server">
    <div >
<%--        <div id="chartContainer" style="height: 500px; width: 500px">
        </div>--%>
        <div class="demo-container">
            <%--<div id="chart" style="height: 500px; width: 1000px"></div>--%>
            <div id="chartWebService" style="height: 500px; width: 1000px"></div>
        </div>
          <div class="demo-container">
      <div id="pie"></div>
    </div>
    </div>


</asp:Content>
<asp:Content ID="Content3" ContentPlaceHolderID="PageScriptContent" runat="server">
</asp:Content>
