<%@ Page Language="C#" AutoEventWireup="true" CodeFile="Default.aspx.cs" Inherits="INTRA.DevEtreme_Dashboard.Default" %>

<!DOCTYPE html PUBLIC "-//W3C//DTD XHTML 1.0 Transitional//EN" "http://www.w3.org/TR/xhtml1/DTD/xhtml1-transitional.dtd">
<html xmlns="http://www.w3.org/1999/xhtml">
<head runat="server">
    <title></title>
    <style type="text/css">
        html, body, form {
            margin: 0;
            padding: 0;
        }
    </style>
      <script type="text/javascript" src="assets/DevExtreme/js/jquery.min.js"></script>
    <script src="assets/DevExtreme/js/cldr.min.js"></script>
    <script src="assets/DevExtreme/js/cldr/event.min.js"></script>
    <script src="assets/DevExtreme/js/cldr/supplemental.min.js"></script>

   <%-- <script src="js_devextreme/globalize.min.js"></script>
    <script src="js_devextreme/globalize/message.min.js"></script>
    <script src="js_devextreme/globalize/number.min.js"></script>
    <script src="js_devextreme/globalize/currency.min.js"></script>
    <script src="js_devextreme/globalize/date.min.js"></script>--%>
    
    <script type="text/javascript" src="assets/DevExtreme/js/dx.all.js"></script>
    <%--<script type="text/javascript" src="js_devextreme/vectormap-data/world.js"></script>
    <script type="text/javascript" src="js_devextreme/vectormap-data/africa.js"></script>
    <script type="text/javascript" src="js_devextreme/vectormap-data/canada.js"></script>
    <script type="text/javascript" src="js_devextreme/vectormap-data/eurasia.js"></script>
    <script type="text/javascript" src="js_devextreme/vectormap-data/europe.js"></script>
    <script type="text/javascript" src="js_devextreme/vectormap-data/usa.js"></script>--%>
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


</head>
<body class="dx-viewport">
    <form id="frmMain" runat="server">
        <div id="chartContainer" style="height: 500px; width: 500px">
        </div>
        <div class="demo-container">
            <div id="chart"  style="height: 500px; width: 1000px"></div>
        </div>

    </form>
</body>
</html>
