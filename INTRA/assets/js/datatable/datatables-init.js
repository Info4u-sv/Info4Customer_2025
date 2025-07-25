var InitiateSimpleDataTable = function () {
    return {
        init: function () {
            //Datatable Initiating
            var oTable = $('#simpledatatable').dataTable({
                "sDom": "Tflt<'row DTTTFooter'<'col-sm-6'i><'col-sm-6'p>>",
                "iDisplayLength": 5,
                "oTableTools": {
                    "aButtons": [
                        "copy", "csv", "xls", "pdf", "print"
                    ],
                    "sSwfPath": "assets/swf/copy_csv_xls_pdf.swf"
                },
                "language": {
                    "search": "",
                    "sLengthMenu": "_MENU_",
                    "oPaginate": {
                        "sPrevious": "Prev",
                        "sNext": "Next"
                    }
                },
                "aoColumns": [
                    {
                        "bSortable": false,
                        "width":'45px'
                    },
                  null,
                  { "bSortable": false },
                  null,
                  { "bSortable": false }
                ],
                "aaSorting": []
            });

            //Check All Functionality
            $('#simpledatatable thead th input[type=checkbox]').change(function () {
                var set = $("#simpledatatable tbody tr input[type=checkbox]");
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
            $('#simpledatatable tbody tr input[type=checkbox]').change(function () {
                $(this).parents('tr').toggleClass("active");
            });

        }

    };

}();
var InitiateEditableDataTable = function () {
    return {
        init: function () {
            //Datatable Initiating
            var oTable = $('#editabledatatable').dataTable({
                "aLengthMenu": [
                    [5, 15, 20, 100, -1],
                    [5, 15, 20, 100, "All"]
                ],
                "iDisplayLength": 5,
                "sPaginationType": "bootstrap",
                "sDom": "Tflt<'row DTTTFooter'<'col-sm-6'i><'col-sm-6'p>>",
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
                },
                "aoColumns": [
                  null,
                  null,
                  null,
                  null,
                  { "bSortable": false }
                ]
            });

            var isEditing = null;

            //Add New Row
            $('#editabledatatable_new').click(function (e) {
                e.preventDefault();
                var aiNew = oTable.fnAddData(['', '', '', '',
                        '<a href="#" class="btn btn-success btn-xs save"><i class="fa fa-edit"></i> Save</a> <a href="#" class="btn btn-warning btn-xs cancel" data-mode="new"><i class="fa fa-times"></i> Cancel</a>'
                ]);
                var nRow = oTable.fnGetNodes(aiNew[0]);
                editAddedRow(oTable, nRow);
                isEditing = nRow;
            });

            //Delete an Existing Row
            $('#editabledatatable').on("click", 'a.delete', function (e) {
                e.preventDefault();

                if (confirm("Are You Sure To Delete This Row?") == false) {
                    return;
                }

                var nRow = $(this).parents('tr')[0];
                oTable.fnDeleteRow(nRow);
                alert("Row Has Been Deleted!");
            });

            //Cancel Editing or Adding a Row
            $('#editabledatatable').on("click", 'a.cancel', function (e) {
                e.preventDefault();
                if ($(this).attr("data-mode") == "new") {
                    var nRow = $(this).parents('tr')[0];
                    oTable.fnDeleteRow(nRow);
                    isEditing = null;
                } else {
                    restoreRow(oTable, isEditing);
                    isEditing = null;
                }
            });

            //Edit A Row
            $('#editabledatatable').on("click", 'a.edit', function (e) {
                e.preventDefault();

                var nRow = $(this).parents('tr')[0];

                if (isEditing !== null && isEditing != nRow) {
                    restoreRow(oTable, isEditing);
                    editRow(oTable, nRow);
                    isEditing = nRow;
                } else {
                    editRow(oTable, nRow);
                    isEditing = nRow;
                }
            });

            //Save an Editing Row
            $('#editabledatatable').on("click", 'a.save', function (e) {
                e.preventDefault();
                if (this.innerHTML.indexOf("Save") >= 0) {
                    saveRow(oTable, isEditing);
                    isEditing = null;
                    //Some Code to Highlight Updated Row
                }
            });


            function restoreRow(oTable, nRow) {
                var aData = oTable.fnGetData(nRow);
                var jqTds = $('>td', nRow);

                for (var i = 0, iLen = jqTds.length; i < iLen; i++) {
                    oTable.fnUpdate(aData[i], nRow, i, false);
                }

                oTable.fnDraw();
            }

            function editRow(oTable, nRow) {
                var aData = oTable.fnGetData(nRow);
                var jqTds = $('>td', nRow);
                jqTds[0].innerHTML = '<input type="text" class="form-control input-small" value="' + aData[0] + '">';
                jqTds[1].innerHTML = '<input type="text" class="form-control input-small" value="' + aData[1] + '">';
                jqTds[2].innerHTML = '<input type="text" class="form-control input-small" value="' + aData[2] + '">';
                jqTds[3].innerHTML = '<input type="text" class="form-control input-small" value="' + aData[3] + '">';
                jqTds[4].innerHTML = '<a href="#" class="btn btn-success btn-xs save"><i class="fa fa-save"></i> Save</a> <a href="#" class="btn btn-warning btn-xs cancel"><i class="fa fa-times"></i> Cancel</a>';
            }

            function editAddedRow(oTable, nRow) {
                var aData = oTable.fnGetData(nRow);
                var jqTds = $('>td', nRow);
                jqTds[0].innerHTML = '<input type="text" class="form-control input-small" value="' + aData[0] + '">';
                jqTds[1].innerHTML = '<input type="text" class="form-control input-small" value="' + aData[1] + '">';
                jqTds[2].innerHTML = '<input type="text" class="form-control input-small" value="' + aData[2] + '">';
                jqTds[3].innerHTML = '<input type="text" class="form-control input-small" value="' + aData[3] + '">';
                jqTds[4].innerHTML = aData[4];
            }

            function saveRow(oTable, nRow) {
                var jqInputs = $('input', nRow);
                oTable.fnUpdate(jqInputs[0].value, nRow, 0, false);
                oTable.fnUpdate(jqInputs[1].value, nRow, 1, false);
                oTable.fnUpdate(jqInputs[2].value, nRow, 2, false);
                oTable.fnUpdate(jqInputs[3].value, nRow, 3, false);
                oTable.fnUpdate('<a href="#" class="btn btn-info btn-xs edit"><i class="fa fa-edit"></i> Edit</a> <a href="#" class="btn btn-danger btn-xs delete"><i class="fa fa-trash-o"></i> Delete</a>', nRow, 4, false);
                oTable.fnDraw();
            }

            function cancelEditRow(oTable, nRow) {
                var jqInputs = $('input', nRow);
                oTable.fnUpdate(jqInputs[0].value, nRow, 0, false);
                oTable.fnUpdate(jqInputs[1].value, nRow, 1, false);
                oTable.fnUpdate(jqInputs[2].value, nRow, 2, false);
                oTable.fnUpdate(jqInputs[3].value, nRow, 3, false);
                oTable.fnUpdate('<a href="#" class="btn btn-info btn-xs edit"><i class="fa fa-edit"></i> Edit</a> <a href="#" class="btn btn-danger btn-xs delete"><i class="fa fa-trash-o"></i> Delete</a>', nRow, 4, false);
                oTable.fnDraw();
            }
        }

    };
}();
var InitiateExpandableDataTable = function () {
    return {
        init: function () {
            /* Formatting function for row details */
            function fnFormatDetails(oTable, nTr) {
                var aData = oTable.fnGetData(nTr);
                var sOut = '<table>';
                sOut += '<tr><td rowspan="5" style="padding:0 10px 0 0;"></td><td>Ticket Associati:</td><td><a href="/Ticket/Ticket_View?IdTicket=' + aData[6] + '">' + aData[6] + '</a></td></tr>';
                //sOut += '<tr><td>Others:</td><td>Personal WebSite</a></td></tr>';
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
                    { "bVisible": false, "aTargets": [6] }
                     
                ],
                "aaSorting": [[1, 'asc']],
                "aLengthMenu": [
                   [5, 15, 20, -1],
                   [5, 15, 20, "All"]
                ],
                "iDisplayLength": 20,
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


            $("#expandabledatatable tfoot input").keyup(function () {
                /* Filter on the column (the index) of this element */
                oTable.fnFilter(this.value, $("#expandabledatatable tfoot input").index(this));
            });
            $("#expandabledatatable thead input").keyup(function () {
                /* Filter on the column (the index) of this element */
                oTable.fnFilter(this.value, $("#expandabledatatable thead input").index(this));
            });



            $('body').on('click', '.dropdown-menu.hold-on-click', function (e) {
                e.stopPropagation();
            })
        }
    };
}();
var InitiateExpandableDataTable_T2 = function () {
    return {
        init: function () {
            /* Formatting function for row details */
            function fnFormatDetails(oTable, nTr) {
                var aData = oTable.fnGetData(nTr);
                var sOut = '<table>';
                sOut += '<tr><td rowspan="5" style="padding:0 10px 0 0;"></td><td>Ticket Associati:</td><td><a href="/Ticket/Ticket_View?IdTicket=' + aData[6] + '">' + aData[6] + '</a></td></tr>';
                //sOut += '<tr><td>Others:</td><td>Personal WebSite</a></td></tr>';
                sOut += '</table>';
                return sOut;
            }

            /*
             * Insert a 'details' column to the table
             */
            var nCloneTh = document.createElement('th');
            var nCloneTd = document.createElement('td');
            nCloneTd.innerHTML = '<i class="fa fa-plus-square-o row-details"></i>';

            $('#expandabledatatable_T2 thead tr').each(function () {
                this.insertBefore(nCloneTh, this.childNodes[0]);
            });

            $('#expandabledatatable_T2 tbody tr').each(function () {
                this.insertBefore(nCloneTd.cloneNode(true), this.childNodes[0]);
            });

            /*
             * Initialize DataTables, with no sorting on the 'details' column
             */
            var oTable = $('#expandabledatatable_T2').dataTable({
                "sDom": "Tflt<'row DTTTFooter'<'col-sm-6'i><'col-sm-6'p>>",
                "aoColumnDefs": [
                    { "bSortable": false, "aTargets": [0] },
                    { "bVisible": false, "aTargets": [6] }

                ],
                "aaSorting": [[1, 'asc']],
                "aLengthMenu": [
                   [5, 15, 20, -1],
                   [5, 15, 20, "All"]
                ],
                "iDisplayLength": 5,
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


            $('#expandabledatatable_T2').on('click', ' tbody td .row-details', function () {
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

            $('#expandabledatatable_T2_column_toggler input[type="checkbox"]').change(function () {
                var iCol = parseInt($(this).attr("data-column"));
                var bVis = oTable.fnSettings().aoColumns[iCol].bVisible;
                oTable.fnSetColumnVis(iCol, (bVis ? false : true));
            });


            $("#expandabledatatable_T2 tfoot input").keyup(function () {
                /* Filter on the column (the index) of this element */
                oTable.fnFilter(this.value, $("#expandabledatatable_T2 tfoot input").index(this));
            });
            $("#expandabledatatable_T2 thead input").keyup(function () {
                /* Filter on the column (the index) of this element */
                oTable.fnFilter(this.value, $("#expandabledatatable_T2 thead input").index(this));
            });


            $('body').on('click', '.dropdown-menu.hold-on-click', function (e) {
                e.stopPropagation();
            })
        }
    };
}();


var InitiateSearchableDataTable = function () {
    return {
        init: function () {
            var oTable = $('#searchable').dataTable({
                
                "sDom": "Tflt<'row DTTTFooter'<'col-sm-6'i><'col-sm-6'p>>",                
                "bRetrieve": true,
                //"bStateSave": true,
                "aaSorting": [[0, 'desc']],
                "aLengthMenu": [
                   [10, 20, 30, -1],
                   [10, 20, 30, "Tutti"]
                ],
                
                "columnDefs": [
                    {
                        "targets": [0],
                        "visible": true,
                        "searchable": true,
                        "type": "num"

                    }
                    ,
                    { "type": "date-eu", "targets": [1] }
                ],
                "iDisplayLength": 30,
                "oTableTools": {
                    "aButtons": [
				        
				        "print",
				        {
				            "sExtends": "collection",
				            "sButtonText": "Salva <i class=\"fa fa-angle-down\"></i>",
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
                },

            });

            $("#searchable tfoot input").keyup(function () {
                /* Filter on the column (the index) of this element */
                oTable.fnFilter(this.value, $("#searchable tfoot input").index(this));
            });
            $("#searchable thead input").keyup(function () {
                /* Filter on the column (the index) of this element */
                oTable.fnFilter(this.value, $("#searchable thead input").index(this));
            });

        }
    }
}();
var InitiateSearchable_T2DataTable = function () {
    return {
        init: function () {
            var oTable = $('#searchable_T2').dataTable({

                "sDom": "Tflt<'row DTTTFooter'<'col-sm-6'i><'col-sm-6'p>>",
                "bRetrieve": true,
                //"bStateSave": true,
                "aaSorting": [[0, 'desc']],
                "aLengthMenu": [
                   [10, 20, 30, -1],
                   [10, 20, 30, "Tutti"]
                ],
             
                "columnDefs": [
                    {
                        "targets": [0],
                        "visible": true,
                        "searchable": true,
                        "type": "num"
                    }
                                        ,
                    { "type": "date-eu", "targets": [1] }

                ],
                "iDisplayLength": 30,
                "oTableTools": {
                    "aButtons": [

				        "print",
				        {
				            "sExtends": "collection",
				            "sButtonText": "Salva <i class=\"fa fa-angle-down\"></i>",
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
                },

            });

            $("#searchable_T2 tfoot input").keyup(function () {
                /* Filter on the column (the index) of this element */
                oTable.fnFilter(this.value, $("#searchable_T2 tfoot input").index(this));
            });
            $("#searchable_T2 thead input").keyup(function () {
                /* Filter on the column (the index) of this element */
                oTable.fnFilter(this.value, $("#searchable_T2 thead input").index(this));
            });

        }
    }
}();
var InitiateSearchable_T3DataTable = function () {
    return {
        init: function () {
            var oTable = $('#searchable_T3').dataTable({

                "sDom": "Tflt<'row DTTTFooter'<'col-sm-6'i><'col-sm-6'p>>",
                "bRetrieve": true,
                //"bStateSave": true,
                "aaSorting": [[0, 'desc']],
                "aLengthMenu": [
                   [10, 20, 30, -1],
                   [10, 20, 30, "Tutti"]
                ],
               
                "columnDefs": [
                    {
                        "targets": [0],
                        "visible": true,
                        "searchable": true,
                        "type": "num"
                    }
                                        ,
                    { "type": "date-eu", "targets": [1] }

                ],
                "iDisplayLength": 30,
                "oTableTools": {
                    "aButtons": [

				        "print",
				        {
				            "sExtends": "collection",
				            "sButtonText": "Salva <i class=\"fa fa-angle-down\"></i>",
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
                },

            });

            $("#searchable_T3 tfoot input").keyup(function () {
                /* Filter on the column (the index) of this element */
                oTable.fnFilter(this.value, $("#searchable_T3 tfoot input").index(this));
            });
            $("#searchable_T3 thead input").keyup(function () {
                /* Filter on the column (the index) of this element */
                oTable.fnFilter(this.value, $("#searchable_T3 thead input").index(this));
            });

        }
    }
}();
var InitiateSearchable_T4DataTable = function () {
    return {
        init: function () {
            var oTable = $('#searchable_T4').dataTable({

                "sDom": "Tflt<'row DTTTFooter'<'col-sm-6'i><'col-sm-6'p>>",
                "bRetrieve": true,
                //"bStateSave": true,
                "aaSorting": [[0, 'desc']],
                "aLengthMenu": [
                   [10, 20, 30, -1],
                   [10, 20, 30, "Tutti"]
                ],
                "order": [[0, "desc"]],
                "columnDefs": [
                    {
                        "targets": [0],
                        "visible": true,
                        "searchable": true,
                        "type": "num"
                    }
                                        ,
                    { "type": "date-eu", "targets": [1] }

                ],
                "iDisplayLength": 30,
                "oTableTools": {
                    "aButtons": [

				        "print",
				        {
				            "sExtends": "collection",
				            "sButtonText": "Salva <i class=\"fa fa-angle-down\"></i>",
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
                },

            });

            $("#searchable_T4 tfoot input").keyup(function () {
                /* Filter on the column (the index) of this element */
                oTable.fnFilter(this.value, $("#searchable_T4 tfoot input").index(this));
            });
            $("#searchable_T4 thead input").keyup(function () {
                /* Filter on the column (the index) of this element */
                oTable.fnFilter(this.value, $("#searchable_T4 thead input").index(this));
            });

        }
    }
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

                "columnDefs": [
                    {
                        "targets": [0],
                        "visible": true,
                        "searchable": true,
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

var InitiateSearchableDataHTML5_T3Table = function () {
    return {
        init: function () {
            var oTable = $('#searchableHTML5_T3').dataTable({

                //"dom": '<"top"i>rt<"bottom"flp><"clear">',
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
                        "visible": true,
                        "searchable": true,
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
                "bRetrieve": true,               
                "aaSorting": [[0, 'desc']],
                "columnDefs": [
                    {
                        "targets": [0],
                        "visible": true,
                        "searchable": true,
                        "type": "num"
                    }
                ],
                        
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

var InitiateSearchableDataHTML5NOIDTable = function () {
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
