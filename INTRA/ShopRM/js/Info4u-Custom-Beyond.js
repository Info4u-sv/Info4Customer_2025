
function CompattaSideBar() {
    $('#sidebar').addClass('menu-compact ');
}

// funzione per visualizzare il modal di conferma operazione legato al validatorgroup
var confirmed = false;
function ShowConfirmBootbox(controlID, textvar, ValidationGroup) {
    if (Page_ClientValidate(ValidationGroup) || ValidationGroup == "NoValidator") {
        if (confirmed) { return true; }
        if (controlID != null) {
            var controlToClick2 = document.getElementById(controlID);
        }
        //if (controlToClick2.id == "btnRemoveLotto") {
        if (controlID != null) {
            //alert("sono qui " + controlToClick2.id);
            //alert("ButtonEditConfirmRow "+ controlToClick2.id);
            bootbox.confirm("Confermi l'operazione di " + textvar + "?", function (result) {
                if (result) {
                    if (controlID != null) {
                        var controlToClick = document.getElementById(controlID);
                        if (controlToClick != null) {
                            confirmed = true;
                            controlToClick.click();
                            confirmed = false;
                            VarformValid = false;
                        }
                    }
                }
            });
        } else { return true }
        return false;
    } else {
        //alert("Else");
        confirmed = false;
    }

}
var confirmed = false;
function ShowConfirmBootboxV2(controlID, textvar) {
    //alert('Sono qui prima');

    if (confirmed) { return true; }
    if (controlID != null) {
        var controlToClick2 = document.getElementById(controlID);
    }

    if (controlID != null) {

        bootbox.confirm("Confermi l'operazione di " + textvar + "?", function (result) {
            if (result) {
                if (controlID != null) {
                    var controlToClick = document.getElementById(controlID);
                    if (controlToClick != null) {
                        confirmed = true;
                        controlToClick.click();
                        confirmed = false;
                        VarformValid = false;
                    }
                }
            }
        });
    } else { return true }
    return false;
}

var InitiateExpandableFatturazioneDataTable = function () {
    return {
        init: function () {
            /* Formatting function for row details */
            function fnFormatDetails(oTable, nTr) {
                var aData = oTable.fnGetData(nTr);
                var sOut = '<table>';
                sOut += '<tr><td rowspan="5" style="padding:20px 20px 20px 20px;"><strong>Lavoro Eseguito:</strong> ' + aData[11] + '</td></tr>';

                sOut += '</table>';
                return sOut;
            }

            /*
             * Insert a 'details' column to the table
             */
            var nCloneTh = document.createElement('th');
            var nCloneTd = document.createElement('td');
            nCloneTd.innerHTML = '<i class="fa fa-plus-square-o row-details"></i>';

            $('#expandabledatatable thead tr').each(function () {
                this.insertBefore(nCloneTh, this.childNodes[0]);
            });

            $('#expandabledatatable tbody tr').each(function () {
                this.insertBefore(nCloneTd.cloneNode(true), this.childNodes[0]);
            });

            /*
             * Initialize DataTables, with no sorting on the 'details' column
             */
            var oTable = $('#expandabledatatable').dataTable({
                "sDom": "Tflt<'row DTTTFooter'<'col-sm-6'i><'col-sm-6'p>>",
                "aoColumnDefs": [
                    { "bSortable": false, "aTargets": [0] },
                    { "bVisible": false, "aTargets": [11] }

                ],
                "aaSorting": [[1, 'desc']],
                "aLengthMenu": [
                    [-1, 5, 15, 20],
                    ["All", 5, 15, 20]
                ],
                "iDisplayLength": "",
                "oTableTools": {
                    "aButtons": [
                        "copy",
                        "print",
                        {
                            "sExtends": "collection",
                            "sButtonText": "Save <i class=\"fa fa-angle-down\"></i>",
                            "aButtons": ["csv", "xls", "pdf"]
                        }],
                    "sSwfPath": "assets/swf/copy_csv_xls_pdf.swf"
                },
                "language": {
                    "search": "",
                    "sLengthMenu": "_MENU_",
                    "oPaginate": {
                        "sPrevious": "Prev",
                        "sNext": "Next"
                    }
                }
            });


            $('#expandabledatatable').on('click', ' tbody td .row-details', function () {
                var nTr = $(this).parents('tr')[0];
                if (oTable.fnIsOpen(nTr)) {
                    /* This row is already open - close it */
                    $(this).addClass("fa-plus-square-o").removeClass("fa-minus-square-o");
                    oTable.fnClose(nTr);
                }
                else {
                    /* Open this row */
                    $(this).addClass("fa-minus-square-o").removeClass("fa-plus-square-o");;
                    oTable.fnOpen(nTr, fnFormatDetails(oTable, nTr), 'details');
                }
            });

            $('#expandabledatatable_column_toggler input[type="checkbox"]').change(function () {
                var iCol = parseInt($(this).attr("data-column"));
                var bVis = oTable.fnSettings().aoColumns[iCol].bVisible;
                oTable.fnSetColumnVis(iCol, (bVis ? false : true));
            });
            //Check All Functionality
            $('#expandabledatatable thead th input[type=checkbox]').change(function () {
                var set = $("#expandabledatatable tbody tr input[type=checkbox]");
                var checked = $(this).is(":checked");
                $(set).each(function () {
                    if (checked) {
                        $(this).prop("checked", true);
                        $(this).parents('tr').addClass("active");
                    } else {
                        $(this).prop("checked", false);
                        $(this).parents('tr').removeClass("active");
                    }
                });
            });
            $('body').on('click', '.dropdown-menu.hold-on-click', function (e) {
                e.stopPropagation();
            })
        }
    };

}();


var InitiateSearchableDataHTML5Table = function () {
    return {
        init: function () {
            var oTable = $('#searchableHTML5').dataTable({

                "sDom": "Bflt<'row DTTTFooter'<'col-sm-6'i><'col-sm-6'p>>",
                dom: 'Bfrtip',

                lengthMenu: [
                    [10, 20, 30, -1],
                    [10, 20, 30, "Tutti"]
                ],
                "language": {
                    "lengthMenu": "_MENU_",
                    "zeroRecords": "Non sono stati trovati risultati",
                    "info": "Pagina _PAGE_ di _PAGES_",
                    "infoEmpty": "Non sono stati trovati risultati",
                    "infoFiltered": "(filtrate da _MAX_ righe totali)",
                    "sSearch": " ",
                    "buttons": {
                        colvis: 'Nascondi Colonne',
                        colvisRestore: 'Visualizza Tutte'
                    },

                    "oPaginate": {
                        "sNext": "Successiva",
                        "sPrevious": "Precedente",
                    },
                },

                "bRetrieve": true,
                "aaSorting": [[0, 'asc']],

                "iDisplayLength": 10,
                buttons: [
                    {
                        extend: 'excelHtml5',
                        exportOptions: {
                            columns: ':visible'
                        }
                    },
                    {
                        extend: 'pdfHtml5',
                        exportOptions: {
                            columns: ':visible'
                        }
                    },
                    {
                        extend: 'colvis',
                        postfixButtons: ['colvisRestore'],
                    }
                ]
            });
            $("#searchableHTML5 tfoot input").keyup(function () {
                /* Filter on the column (the index) of this element */
                oTable.fnFilter(this.value, $("#searchableHTML5 tfoot input").index(this));
            });
            $("#searchableHTML5 thead input").keyup(function () {
                /* Filter on the column (the index) of this element */
                oTable.fnFilter(this.value, $("#searchableHTML5 thead input").index(this));
            });
        }
    }
}();

var InitiateSearchableDataHTML5ClientiTable = function () {
    return {
        init: function () {
            var oTable = $('#searchableHTML5CLI').dataTable({
                "sDom": "Bflt<'row DTTTFooter'<'col-sm-6'i><'col-sm-6'p>>",
                dom: 'Bfrtip',
                lengthMenu: [
                    [10, 20, 30, -1],
                    [10, 20, 30, "Tutti"]
                ],
                "language": {
                    "lengthMenu": "_MENU_",
                    "zeroRecords": "Non ci sono clienti corrispondenti alla tua ricerca <a href='/Anagrafiche/Customer_Kom_Edit_Insert.aspx?rich=offerta'><asp:LinkButton ID='btnInserisci' runat='server'title='Inserisci Cliente' CausesValidation='False' class='btn btn-labeled btn-azure'><i class='btn-label glyphicon glyphicon-plus-sign'></i>Nuovo Cliente</asp:LinkButton></a>",
                    "info": "Pagina _PAGE_ di _PAGES_",
                    "infoEmpty": "Non sono stati trovati risultati",
                    "infoFiltered": "(filtrate da _MAX_ righe totali)",
                    "sSearch": " ",
                    "buttons": {
                        colvis: 'Nascondi Colonne',
                        colvisRestore: 'Visualizza Tutte'
                    },
                    "fnInitComplete": function (oSettings) {
                        oSettings.oLanguage.sZeroRecords = "Non ci sono clienti corrispondenti alla tua ricerca <a href='/Anagrafiche/Customer_Kom_Edit_Insert.aspx'><asp:LinkButton ID='btnInserisci' runat='server'title='Inserisci Cliente' CausesValidation='False' class='btn btn-labeled btn-azure'><i class='btn-label glyphicon glyphicon-plus-sign'></i>Nuovo Cliente</asp:LinkButton></a>"
                    },
                    "oPaginate": {
                        "sNext": "Successiva",
                        "sPrevious": "Precedente",
                    },
                },

                "bRetrieve": true,
                "aaSorting": [[0, 'desc']],
                "columnDefs": [
                    {
                        "targets": [0],
                        "visible": true,
                        "searchable": true,
                        "type": "num"
                    }
                    , { "type": "date-eu", "targets": [1] }

                ],
                "iDisplayLength": 30,
                buttons: [
                    {
                        extend: 'excelHtml5',
                        exportOptions: {
                            columns: ':visible'
                        }
                    },
                    {
                        extend: 'pdfHtml5',
                        exportOptions: {
                            columns: ':visible'
                        }
                    },
                    {
                        extend: 'colvis',
                        postfixButtons: ['colvisRestore'],
                    }
                ]
            });
            $("#searchableHTML5CLI tfoot input").keyup(function () {
                /* Filter on the column (the index) of this element */
                oTable.fnFilter(this.value, $("#searchableHTML5CLI tfoot input").index(this));
            });
            $("#searchableHTML5CLI thead input").keyup(function () {
                /* Filter on the column (the index) of this element */
                oTable.fnFilter(this.value, $("#searchableHTML5CLI thead input").index(this));
            });
        }
    }
}();

var InitiateSearchableDataHTML5_T2Table4u = function () {
    return {
        init: function () {
            var oTable = $('#searchableHTML5_T2').dataTable({
                //"dom": '<"top"i>rt<"bottom"flp><"clear">',
                "sDom": "Bflt<'row DTTTFooter'<'col-sm-6'i><'col-sm-6'p>>",

                dom: 'Bfrtip',
                lengthMenu: [
                    [10, 20, 30, -1],
                    [10, 20, 30, "Tutti"]
                ],


                "language": {
                    "decimal": ",",
                    "thousands": ".",
                    "lengthMenu": "_MENU_",
                    "zeroRecords": "Non sono stati trovati risultati",
                    "info": "Pagina _PAGE_ di _PAGES_",
                    "infoEmpty": "Non sono stati trovati risultati",
                    "infoFiltered": "(filtrate da _MAX_ righe totali)",
                    "sSearch": " ",
                    "buttons": {
                        colvis: 'Nascondi Colonne',
                        colvisRestore: 'Visualizza Tutte'
                    },

                    "oPaginate": {
                        "sNext": "Successiva",
                        "sPrevious": "Precedente",
                    },
                },

                //"sDom": "Tflt<'row DTTTFooter'<'col-sm-6'i><'col-sm-6'p>>",
                "bRetrieve": true,
                //"bStateSave": true,
                "aaSorting": [[0, 'desc']],
                //"LengthMenu": [
                //   [10, 20, 30, -1],
                //   [10, 20, 30, "Tutti"]
                //],

                "columnDefs": [
                    {
                        "targets": [0],
                        "visible": false,
                        "searchable": false,
                        "type": "num"
                    }
                ],
                "iDisplayLength": 30,
                //"oTableTools": {
                //    "aButtons": [

                //        "print",
                //        ]
                //},
                buttons: [

                    //'pageLength',
                    //{
                    //    extend: 'copyHtml5',
                    //    exportOptions: {
                    //        columns: [0, ':visible']
                    //    }
                    //},
                    {
                        extend: 'excelHtml5',
                        exportOptions: {
                            columns: ':visible'
                        }
                    },
                    {
                        extend: 'pdfHtml5',
                        exportOptions: {
                            //columns: [ 0, 1, 2, 5 ]
                            columns: ':visible'
                        }
                    },
                    {
                        extend: 'colvis',
                        postfixButtons: ['colvisRestore'],

                    }


                ]

            });
            $("#searchableHTML5_T2 tfoot input").keyup(function () {
                /* Filter on the column (the index) of this element */
                oTable.fnFilter(this.value, $("#searchableHTML5_T2 tfoot input").index(this));
            });
            $("#searchableHTML5_T2 thead input").keyup(function () {
                /* Filter on the column (the index) of this element */
                oTable.fnFilter(this.value, $("#searchableHTML5_T2 thead input").index(this));
            });
        }
    }
}();



var InitiateSearchableDataHTML5Table_VenditeGestione = function () {
    return {
        init: function () {
            var oTable = $('#searchableHTML5').dataTable({
                initComplete: function () {
                    this.api().columns([5]).every(function () {
                        var column = this;
                        var select = $('<select><option value="">' + 'Pagamento' + '</option></select>')
                            .appendTo($(column.header()).empty())
                            .on('change', function () {
                                var val = $.fn.dataTable.util.escapeRegex(
                                    $(this).val()
                                );

                                column
                                    .search(val ? '^' + val + '$' : '', true, false)
                                    .draw();
                            });

                        column.data().unique().sort().each(function (d, j) {
                            var val = $('<div/>').html(d).text();
                            select.append('<option value="' + val + '">' + val + '</option>');
                        });
                    });
                },
                "aoColumnDefs": [
                    {
                        "aTargets": [0],
                        "bSortable": true,
                        "sType": "num"
                    },
                    //{
                    //    "sType": 'numeric-comma', "aTargets": [2] 

                    //},
                    { "bSortable": false, "aTargets": [5] },
                ],
                "footerCallback": function (row, data, start, end, display) {
                    var api = this.api();

                    api.columns('.sum', {
                        page: 'current'
                    }).every(function () {
                        var sum = this
                            .data()
                            .reduce(function (a, b) {
                                var x = parseFloat(a) || 0;
                                var y = parseFloat(b) || 0;
                                var z = x + y;
                                console.log(a); //alert(sum);
                                console.log(b); //alert(sum);
                                return  z.toFixed(2);
                            }, 0);
                       
                        console.log(sum); //alert(sum);
                        $(this.footer()).html("€ " + sum);
                    });
             
                },

                "sDom": "Bflt<'row DTTTFooter'<'col-sm-6'i><'col-sm-6'p>>",
                dom: 'Bfrtip',
             
                lengthMenu: [
                    [10, 20, 30, -1],
                    [10, 20, 30, "Tutti"]
                ],
                "language": {
                    "decimal": ",",
                    "thousands": ".",
                    "lengthMenu": "_MENU_",
                    "zeroRecords": "Non sono stati trovati risultati",
                    "info": "Pagina _PAGE_ di _PAGES_",
                    "infoEmpty": "Non sono stati trovati risultati",
                    "infoFiltered": "(filtrate da _MAX_ righe totali)",
                    "sSearch": " ",
                    "buttons": {
                        colvis: 'Nascondi Colonne',
                        colvisRestore: 'Visualizza Tutte'
                    },

                    "oPaginate": {
                        "sNext": "Successiva",
                        "sPrevious": "Precedente",
                    },
                },

                "bRetrieve": true,
                "aaSorting": [[0, 'desc']],

                "iDisplayLength": 10,
                buttons: [
                    {
                        extend: 'excelHtml5',
                        exportOptions: {
                            columns: ':visible'
                        }
                    },
                    {
                        extend: 'pdfHtml5',
                        exportOptions: {
                            columns: ':visible'
                        }
                    },
                    {
                        extend: 'colvis',
                        postfixButtons: ['colvisRestore'],
                    }
                ]
            });
            $("#searchableHTML5 tfoot input").keyup(function () {
                /* Filter on the column (the index) of this element */
                oTable.fnFilter(this.value, $("#searchableHTML5 tfoot input").index(this));
            });
            $("#searchableHTML5 thead input").keyup(function () {
                /* Filter on the column (the index) of this element */
                oTable.fnFilter(this.value, $("#searchableHTML5 thead input").index(this));
            });
            $('body').on('click', '.dropdown-menu.hold-on-click', function (e) {
                e.stopPropagation();
            })
        }
    }
}();


