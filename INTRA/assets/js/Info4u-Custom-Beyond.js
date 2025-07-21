
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

// funzione per visualizzare il modal di conferma operazione senza validatorgroup
var confirmed = false;
function ShowConfirmBootboxV2(controlID, textvar) {
    //alert('Sono qui prima');

    if (confirmed) { return true; }
    if (controlID != null) {
        var controlToClick2 = document.getElementById(controlID);
    }
    //alert('Sono qui');
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




var InitiateExpandableFatturazioneDataTable3 = function () {
    return {
        init: function () {
            /* Formatting function for row details */
            function fnFormatDetails(oTable, nTr) {
                var aData = oTable.fnGetData(nTr);
                var sOut = '<div class="row">';
                sOut += '<div class="col-sm-12 col-lg-12 col-md-12">';
                sOut += '<tr><td rowspan="5" style="padding:20px 20px 20px 20px;"><strong style="color: #5db2ff !important ">Lavoro Eseguito:</strong> ' + aData[11] + '</td></tr>';
                sOut += '</div>';
                sOut += '<div class="col-sm-12 col-lg-12 col-md-12">';
                sOut += '<tr><td rowspan="5" style="padding:20px 20px 20px 20px;"><strong style="color: #5db2ff !important ">Note Fatturazione Finale:</strong> ' + aData[12] + '</td></tr>';
                sOut += '</div>';
                return sOut;
            }

            /*
             * Insert a 'details' column to the table
             */
            var nCloneTh = document.createElement('th');
            var nCloneTd = document.createElement('td');
            nCloneTd.innerHTML = '<i class="fa fa-plus-square-o row-details"></i>';

            $('#expandabledatatableFat thead tr').each(function () {
                this.insertBefore(nCloneTh, this.childNodes[0]);
            });

            $('#expandabledatatableFat tbody tr').each(function () {
                this.insertBefore(nCloneTd.cloneNode(true), this.childNodes[0]);
            });

            /*
             * Initialize DataTables, with no sorting on the 'details' column
             */
            var oTable = $('#expandabledatatableFat').dataTable({
                initComplete: function () {
                    this.api().columns([3]).every(function () {
                        var column = this;
                        var select = $('<select><option value="">' + 'Seleziona Area di Competenza' + '</option></select>')
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
                "sDom": "Bflt<'row DTTTFooter'<'col-sm-6'i><'col-sm-6'p>>",
                dom: 'Bfrtip',
                "aoColumnDefs": [
                    { "bSortable": false, "aTargets": [0] },
                    { "bSortable": false, "aTargets": [10] },
                    { "bVisible": false, "aTargets": [11] },
                    { "bVisible": false, "aTargets": [12] },
                    { "sType": "date-eu", "aTargets": [2] },
                    { "bSortable": false, "aTargets": [3] }
                ],
                "aaSorting": [[1, 'desc']],
                lengthMenu: [
                [-1],
               ["Tutti"]
                ],
                "iDisplayLength": -1,

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




            $('#expandabledatatableFat').on('click', ' tbody td .row-details', function () {
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

            $('#expandabledatatableFat_column_toggler input[type="checkbox"]').change(function () {
                var iCol = parseInt($(this).attr("data-column"));
                var bVis = oTable.fnSettings().aoColumns[iCol].bVisible;
                oTable.fnSetColumnVis(iCol, (bVis ? false : true));
            });
            //Check All Functionality
            $('#expandabledatatableFat thead th input[type=checkbox]').change(function () {
                var set = $("#expandabledatatableFat tbody tr input[type=checkbox]");
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

var InitiateExpandableFatturazioneDataTable2 = function () {
    return {
        init: function () {

            /* Formatting function for row details */
            function fnFormatDetails(oTable, nTr) {
                var aData = oTable.fnGetData(nTr);
                var sOut = '<table>';
                sOut += '<tr><td rowspan="5" style="padding:20px 20px 20px 20px;"><strong style="color: #5db2ff !important ">Lavoro Eseguito:</strong> ' + aData[11] + '</td></tr>';
                sOut += '</table>';
                return sOut;
            }

            /*
             * Insert a 'details' column to the table
             */
            var nCloneTh = document.createElement('th');
            var nCloneTd = document.createElement('td');
            nCloneTd.innerHTML = '<i class="fa fa-plus-square-o row-details"></i>';

            $('#expandabledatatableFat thead tr').each(function () {
                this.insertBefore(nCloneTh, this.childNodes[0]);
            });

            $('#expandabledatatableFat tbody tr').each(function () {
                this.insertBefore(nCloneTd.cloneNode(true), this.childNodes[0]);
            });

            /*
             * Initialize DataTables, with no sorting on the 'details' column
             */
            var oTable = $('#expandabledatatableFat').dataTable({

                /* Serve per mettere sulla terza colonna una dropdownlist con i dati riportati sotto */
                initComplete: function () {
                    this.api().columns([3]).every(function () {
                        var column = this;
                        var select = $('<select><option value="">' + 'Seleziona Area di Competenza' + '</option></select>')
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

                "sDom": "Bflt<'row DTTTFooter'<'col-sm-6'i><'col-sm-6'p>>",
                dom: 'Bfrtip',
                "aoColumnDefs": [
                    { "bSortable": false, "aTargets": [0] },
                    { "bSortable": false, "aTargets": [10] },
                    { "bSortable": false, "aTargets": [3] },
                    { "bVisible": false, "aTargets": [11] },
                    { "sType": "date-eu", "aTargets": [2] },
                    { "bSortable": false, "aTargets": [3] }
                ],
                "aaSorting": [[1, 'desc']],
                lengthMenu: [
                [-1],
               ["Tutti"]
                ],
                "iDisplayLength": -1,

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
            $('#expandabledatatableFat').on('click', ' tbody td .row-details', function () {
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

            $('#expandabledatatableFat_column_toggler input[type="checkbox"]').change(function () {
                var iCol = parseInt($(this).attr("data-column"));
                var bVis = oTable.fnSettings().aoColumns[iCol].bVisible;
                oTable.fnSetColumnVis(iCol, (bVis ? false : true));
            });
            //Check All Functionality
            $('#expandabledatatableFat thead th input[type=checkbox]').change(function () {
                var set = $("#expandabledatatableFat tbody tr input[type=checkbox]");
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

var InitiateExpandableFatturazioneDataTable = function () {
    return {
        init: function () {
            /* Formatting function for row details */
            function fnFormatDetails(oTable, nTr) {
                var aData = oTable.fnGetData(nTr);
                var sOut = '<div class="row">';
                sOut += '<div class="col-sm-12 col-lg-12 col-md-12">';
                sOut += '<tr><td rowspan="5" style="padding:20px 20px 20px 20px;"><strong style="color: #5db2ff !important ">Lavoro Eseguito:</strong> ' + aData[11] + '</td></tr>';
                sOut += '</div>';
                sOut += '<div class="col-sm-12 col-lg-12 col-md-12">';
                sOut += '<tr><td rowspan="5" style="padding:20px 20px 20px 20px;"><strong style="color: #5db2ff !important ">Note Fatturazione Finale:</strong> ' + aData[13] + '</td></tr>';
                sOut += '</div>';
                return sOut;
            }

            /*
             * Insert a 'details' column to the table
             */
            var nCloneTh = document.createElement('th');
            var nCloneTd = document.createElement('td');
            nCloneTd.innerHTML = '<i class="fa fa-plus-square-o row-details"></i>';

            $('#expandabledatatableFat thead tr').each(function () {
                this.insertBefore(nCloneTh, this.childNodes[0]);
            });

            $('#expandabledatatableFat tbody tr').each(function () {
                this.insertBefore(nCloneTd.cloneNode(true), this.childNodes[0]);
            });

            /*
             * Initialize DataTables, with no sorting on the 'details' column
             */
            var oTable = $('#expandabledatatableFat').dataTable({
                initComplete: function () {
                    this.api().columns([3]).every(function () {
                        var column = this;
                        var select = $('<select><option value="">' + 'Seleziona Area di Competenza' + '</option></select>')
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
                "sDom": "Bflt<'row DTTTFooter'<'col-sm-6'i><'col-sm-6'p>>",
                dom: 'Bfrtip',
                "aoColumnDefs": [
                    { "bSortable": false, "aTargets": [0] },
                    { "bSortable": false, "aTargets": [10] },
                    { "bVisible": false, "aTargets": [11] },
                { "bVisible": false, "aTargets": [13] },
                    { "sType": "date-eu", "aTargets": [2] },
                    { "bSortable": false, "aTargets": [3] }
                ],
                "aaSorting": [[1, 'desc']],
                lengthMenu: [
                [10, 20, 30, -1],
               [10, 20, 30, "Tutti"]
                ],
                "iDisplayLength": -1,

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




            $('#expandabledatatableFat').on('click', ' tbody td .row-details', function () {
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

            $('#expandabledatatableFat_column_toggler input[type="checkbox"]').change(function () {
                var iCol = parseInt($(this).attr("data-column"));
                var bVis = oTable.fnSettings().aoColumns[iCol].bVisible;
                oTable.fnSetColumnVis(iCol, (bVis ? false : true));
            });
            //Check All Functionality
            $('#expandabledatatableFat thead th input[type=checkbox]').change(function () {
                var set = $("#expandabledatatableFat tbody tr input[type=checkbox]");
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
                "aoColumnDefs": [
  {
      "aTargets": [0],
      "bSortable": true,
      "sType": "num"
  }
, { "sType": "date-eu", "aTargets": [1] }
                ],
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
                "aaSorting": [[0, 'desc']],

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

var InitiateSearchableDataHTML5_T2Table = function () {
    return {
        init: function () {
            var oTable = $('#searchableHTML5_T2').dataTable({
                //"dom": '<"top"i>rt<"bottom"flp><"clear">',
                "sDom": "Bflt<'row DTTTFooter'<'col-sm-6'i><'col-sm-6'p>>",

                dom: 'Bfrtip',
                "aoColumnDefs": [
  {
      "aTargets": [0],
      "bSortable": true,
      "sType": "num"
  }
, { "sType": "date-eu", "aTargets": [1] }
                ],

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

                //"sDom": "Tflt<'row DTTTFooter'<'col-sm-6'i><'col-sm-6'p>>",
                "bRetrieve": true,
                //"bStateSave": true,
                "aaSorting": [[0, 'desc']],
                //"LengthMenu": [
                //   [10, 20, 30, -1],
                //   [10, 20, 30, "Tutti"]
                //],


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

var InitiateSearchableDataHTML5_T3Table = function () {
    return {
        init: function () {
            var oTable = $('#searchableHTML5_T3').dataTable({

                //"dom": '<"top"i>rt<"bottom"flp><"clear">',
                "sDom": "Bflt<'row DTTTFooter'<'col-sm-6'i><'col-sm-6'p>>",

                dom: 'Bfrtip',
                "aoColumnDefs": [
  {
      "aTargets": [0],
      "bSortable": true,
      "sType": "num"
  }
, { "sType": "date-eu", "aTargets": [1] }
                ],

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

                //"sDom": "Tflt<'row DTTTFooter'<'col-sm-6'i><'col-sm-6'p>>",
                "bRetrieve": true,
                //"bStateSave": true,
                "aaSorting": [[0, 'desc']],
                //"LengthMenu": [
                //   [10, 20, 30, -1],
                //   [10, 20, 30, "Tutti"]
                //],


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

            $("#searchableHTML5_T3 tfoot input").keyup(function () {
                /* Filter on the column (the index) of this element */
                oTable.fnFilter(this.value, $("#searchableHTML5_T3 tfoot input").index(this));
            });
            $("#searchableHTML5_T3 thead input").keyup(function () {
                /* Filter on the column (the index) of this element */
                oTable.fnFilter(this.value, $("#searchableHTML5_T3 thead input").index(this));
            });
        }
    }
}();

var InitiateSearchableDataHTML5_T4Table = function () {
    return {
        init: function () {
            var oTable = $('#searchableHTML5_T4').dataTable({

                //"dom": '<"top"i>rt<"bottom"flp><"clear">',
                "sDom": "Bflt<'row DTTTFooter'<'col-sm-6'i><'col-sm-6'p>>",
                dom: 'Bfrtip',
                "aoColumnDefs": [
                  {
                      "aTargets": [0],
                      "bSortable": true,
                      "sType": "num"
                  }
              , { "sType": "date-eu", "aTargets": [1] }
                ],
                lengthMenu: [
                 [10, 20, 30, -1],
                [10, 20, 30, "Tutti"]
                ],
                "iDisplayLength": 30,
                "language": {
                    "lengthMenu": "_MENU_",
                    "zeroRecords": "Non sono stati trovati risultati",
                    "info": "Pagina _PAGE_ di _PAGES_ ",
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

                "aaSorting": [[0, 'desc']],


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

            $("#searchableHTML5_T4 tfoot input").keyup(function () {
                /* Filter on the column (the index) of this element */
                oTable.fnFilter(this.value, $("#searchableHTML5_T4 tfoot input").index(this));
            });
            $("#searchableHTML5_T4 thead input").keyup(function () {
                /* Filter on the column (the index) of this element */
                oTable.fnFilter(this.value, $("#searchableHTML5_T4 thead input").index(this));
            });
        }
    }
}();