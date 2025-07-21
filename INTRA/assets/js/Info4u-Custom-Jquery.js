function ValidatePage() {
    //alert("ValidatePage")
    if (typeof (Page_ClientValidate) == 'function') {
        Page_ClientValidate();
    }
   
    if (isValid) {
        Notify('La pagina è valida!', 'top-left', '5000', 'danger', 'fa-bolt', true);
        return true;
        
    }
    else {
        //alert("la pagina non è valida. Ricorda che se non lo è quel popoup non si scatena")
        Notify('La pagina non è valida!', 'top-left', '5000', 'danger', 'fa-bolt', true);
        return false;
       
    }
}
var confirmed = false;
function confirmDialog(obj, Vartitle, dialogText) {
    if (ValidatePage()) {
        if (!confirmed) {
            $('#myModalMsg').on('show.bs.modal', function (event) {
                var button = $(event.relatedTarget) // Button that triggered the modal
                var recipient = button.data('whatever') // Extract info from data-* attributes                              
                // If necessary, you could initiate an AJAX request here (and then do the updating in a callback).
                // Update the modal's content. We'll use jQuery here, but you could use a data binding library or other methods instead.
                var modal = $(this)
                modal.find('.modal-title').text(Vartitle)
                modal.find('.modal-body').text(dialogText)
            })
            $('#myModalMsg').modal('show');
            $("#btnMdlConfirm").click(function () {
                confirmed = true; obj.click();
            });
        }
    }
    return confirmed;
}

function fnRedrawTootlip() {
    $('[data-toggle="tooltip"]').tooltip();
}

function fnClickRedraw() {

    $('.btn-setting').click(function (e) {
        e.preventDefault();
        $('#myModal').modal('show');
    });
    // Questo script va richiamato con una funzione prerender nella codice c#
    $('[id^="table"]').dataTable({

        "sDom": "<'row-fluid'<'span6'l><'span6'f>r>t<'row-fluid'<'span12'i><'span12 center'p>>",
        "sPaginationType": "bootstrap",
        "oLanguage": {
            "sEmptyTable": "Nessun dato presente nella tabella",
            "sInfo": "Vista da _START_ a _END_ di _TOTAL_ elementi",
            "sInfoEmpty": "Vista da 0 a 0 di 0 elementi",
            "sInfoFiltered": "(filtrati da _MAX_ elementi totali)",
            "sInfoPostFix": "",
            "sInfoThousands": ",",
            "sLengthMenu": "Visualizza _MENU_ elementi",
            "sLoadingRecords": "Caricamento...",
            "sProcessing": "Elaborazione...",
            "sSearch": "Cerca:",
            "sZeroRecords": "La ricerca non ha portato alcun risultato.",
            "oPaginate": {
                "sFirst": "Inizio",
                "sPrevious": "Precedente",
                "sNext": "Successivo",
                "sLast": "Fine"
            },
            "oAria": {
                "sSortAscending": ": attiva per ordinare la colonna in ordine crescente",
                "sSortDescending": ": attiva per ordinare la colonna in ordine decrescente"
            }
        }
    });
};



function fnClickRedrawInfiniteTable() {

    $('[scroll="infinite"]').dataTable({

        "sDom": "<'row-fluid'<'span6'l><'span6'f>r>t<'row-fluid'<'span12'i><'span12 center'p>>",
        "sPaginationType": "bootstrap",
        "oLanguage": {
            "sEmptyTable": "Nessun dato presente nella tabella",
            "sInfo": "Vista da _START_ a _END_ di _TOTAL_ elementi",
            "sInfoEmpty": "Vista da 0 a 0 di 0 elementi",
            "sInfoFiltered": "(filtrati da _MAX_ elementi totali)",
            "sInfoPostFix": "",
            "sInfoThousands": ",",
            "sLengthMenu": "Visualizza _MENU_ elementi",
            "sLoadingRecords": "Caricamento...",
            "sProcessing": "Elaborazione...",
            "sSearch": "Cerca:",
            "sZeroRecords": "La ricerca non ha portato alcun risultato.",
            "oPaginate": {
                "sFirst": "Inizio",
                "sPrevious": "Precedente",
                "sNext": "Successivo",
                "sLast": "Fine"
            },
            "oAria": {
                "sSortAscending": ": attiva per ordinare la colonna in ordine crescente",
                "sSortDescending": ": attiva per ordinare la colonna in ordine decrescente"
            }
        },
        "scrollY": "300px",
        "scrollCollapse": true,
        "paging": false,
        "select": true

    });

    //SCRIPT DATATBLE PER OTTENERE IL NUMERO DI RIGHE SELEZIONATE

//    $(document).ready(function () {
//        var table = $('#example').DataTable();

//        $('#example tbody').on('click', 'tr', function () {
//            $(this).toggleClass('selected');
//        });
//        /*var tt = TableTools.fnGetInstance('example');
//        var indexes = tt.fnGetSelectedIndexes();*/
//        $('#button').click(function () {
//            var hdnfldVariable = document.getElementById('hdnfldVariable');
//            
//            hdnfldVariable.value = table.rows('.selected').data().length + ' row(s) selected';
//            //alert(table.rows('.selected').data().length + ' row(s) selected');
//        });
//    });

};


function fnClickRedrawInfiniteTable2() {

   $(document).ready(function() {
    var selected = [];
 
    $('[scroll="infinite"]').DataTable({
        "processing": true,
        "serverSide": true,
        //"ajax": "scripts/ids-arrays.php",
        "rowCallback": function( row, data ) {
            if ( $.inArray(data.DT_RowId, selected) !== -1 ) {
                $(row).addClass('selected');
            }
        }
    });
 
    $('#example tbody').on('click', 'tr', function () {
        var id = this.id;
        var index = $.inArray(id, selected);
 
        if ( index === -1 ) {
            selected.push( id );
        } else {
            selected.splice( index, 1 );
        }
 
        $(this).toggleClass('selected');
    } );
} );

};



//questa funzione serve per il popoup di avviso in quelle pagine in cui non si verifica un postback. Serve inoltre per quelle pagine che non vanno validate
function confirmDialogWithNoPostBack(obj, Vartitle, dialogText) {
    //if (ValidatePage()) {
    alert('sono nel modal');
    if (!confirmed) {
        $('#myModalMsg').on('show.bs.modal', function (event) {
            var button = $(event.relatedTarget) // Button that triggered the modal
            var recipient = button.data('whatever') // Extract info from data-* attributes                              
            // If necessary, you could initiate an AJAX request here (and then do the updating in a callback).
            // Update the modal's content. We'll use jQuery here, but you could use a data binding library or other methods instead.
            var modal = $(this)
            modal.find('.modal-title').text(Vartitle)
            modal.find('.modal-body').text(dialogText)
        })
        $('#myModalMsg').modal('show');
        $("#btnMdlConfirm").click(function () {
            confirmed = true; obj.click();
        });
    }
    //}
    return confirmed;

}

//Modal rosso per eliminazione (non è necessario validare la pagina)
function confirmDangerDialog(obj, Vartitle, dialogText) {
        if (!confirmed) {
            $('#myModalMsgDanger').on('show.bs.modal', function (event) {
                var button = $(event.relatedTarget) // Button that triggered the modal
                var recipient = button.data('whatever') // Extract info from data-* attributes                              
                // If necessary, you could initiate an AJAX request here (and then do the updating in a callback).
                // Update the modal's content. We'll use jQuery here, but you could use a data binding library or other methods instead.
                var modal = $(this)
                modal.find('.modal-title').text(Vartitle)
                modal.find('.modal-body').text(dialogText)
            })
            $('#myModalMsgDanger').modal('show');
            $("#btnMdlConfirmDanger").click(function () {
                confirmed = true; obj.click();
            });
        }
    return confirmed;
}

//riscatena l'elemento datepicker
function redrawDatePicker() {
    $('.datepicker').datepicker();
}


//editor html per le descrizioni
//$(window).load(
//    function () {

//        tinymce.init({
//            selector: ".tinymce",
//            theme: "modern",
//            /*width: 500,
//            height: 400,*/
//            plugins: [
//         "advlist autolink link image lists charmap print preview hr anchor pagebreak spellchecker",
//         "searchreplace wordcount visualblocks visualchars code fullscreen insertdatetime media nonbreaking",
//         "save table contextmenu directionality emoticons template paste textcolor"
//   ],
//            content_css: "css/content.css",
//            toolbar: "insertfile undo redo | styleselect | bold italic | alignleft aligncenter alignright alignjustify | bullist numlist outdent indent | l      ink image | print preview media fullpage | forecolor backcolor emoticons",
//            style_formats: [
//        { title: 'Bold text', inline: 'b' },
//        { title: 'Red text', inline: 'span', styles: { color: '#ff0000'} },
//        { title: 'Red header', block: 'h1', styles: { color: '#ff0000'} },
//        { title: 'Example 1', inline: 'span', classes: 'example1' },
//        { title: 'Example 2', inline: 'span', classes: 'example2' },
//        { title: 'Table styles' },
//        { title: 'Table row 1', selector: 'tr', classes: 'tablerow1' }
//    ]
//        });
//    }
//);

//la lista seleziona massimo un elemento, indipendentemente da quanti dati vengono caricati
function redrawSelectForSpecificheCli() {
    //chosen - improves select
    $('[data-rel="chosen"],[rel="chosen"]').chosen({ max_selected_options: 1 });
}


function redrawSelect() {

    $('[maxSelected="1"]').chosen({ max_selected_options: 1 });

    $('[maxSelected="2"]').chosen({ max_selected_options: 2 });

    $('[maxSelected="-1"]').chosen();
}

//function redrawSelectLimiteOne() {
//    $('[maxSelected="1"]').chosen({ max_selected_options: 1 });
//}

//ridefinisce le checkbox con stile "iphone toggle"
function redrawIphoneToggle() {
    //iOS / iPhone style toggle switch
    $('.iphone-toggle').iphoneStyle();
}

//questa funzione serve per il popoup di avviso in quelle pagine in cui non si verifica un postback. Serve inoltre per quelle pagine che non vanno validate
function confirmDialogBootBox(obj, Vartitle, dialogText) {
    //if (ValidatePage()) {
    if (!confirmed) {
        bootbox.dialog({
            message: dialogText,
            title: Vartitle,
            buttons: {
                success: {
                    label: "Conferma!",
                    className: "btn-success",
                    callback: function () {
                        confirmed = true;
                    }
                },
                danger: {
                    label: "Annulla!",
                    className: "btn-danger",
                    callback: function () {
                        confirmed = false;

                    }
                },
                main: {
                    label: "Annulla!",
                    className: "btn-primary",
                    callback: function () {
                        confirmed = false;

                    }
                }
            }
        });


        //$('#myModalMsg').on('show.bs.modal', function (event) {
        //    var button = $(event.relatedTarget) // Button that triggered the modal
        //    var recipient = button.data('whatever') // Extract info from data-* attributes                              
        //    // If necessary, you could initiate an AJAX request here (and then do the updating in a callback).
        //    // Update the modal's content. We'll use jQuery here, but you could use a data binding library or other methods instead.
        //    var modal = $(this)
        //    modal.find('.modal-title').text(Vartitle)
        //    modal.find('.modal-body').text(dialogText)
        //})
        //$('#myModalMsg').modal('show');
        //$("#btnMdlConfirm").click(function () {
        //    confirmed = true; obj.click();
        //});
    }
    //}
    return confirmed;

}
