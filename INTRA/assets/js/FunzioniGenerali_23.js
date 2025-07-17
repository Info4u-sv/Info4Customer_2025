function roundNumber(number, decimals) {
    var firstParam = "e+" + decimals;
    var secondParam = "e-" + decimals;
    return +(Math.round(number + firstParam) + secondParam);
}

function showNotification() {
    type = ['success'];
    $.notify({
        icon: "notifications",
        message: "PROCEDURA ESEGUITA CON SUCCESSO!"
    }, {
        type: type,
        timer: 3000,
        placement: {
            from: 'top',
            align: 'right'
        }
    });
}
function showNotificationError() {
    type = ['danger'];
    $.notify({
        icon: "error",
        message: "Non esiste alcuna scheda per questo articolo, creare una scheda e riprovare"
    }, {

        type: type,
        timer: 3000,
        placement: {
            from: 'top',
            align: 'right'
        }
    });
}

function showNotificationErrorWithText(message) {
    type = ['danger'];
    $.notify({
        icon: "error",
        message: message
    }, {

        type: type,
        timer: 3000,
        placement: {
            from: 'top',
            align: 'right'
        }
    });
}
function Notify(msg, title, type, clear, pos, sticky) {
    toastr.options.positionClass = "toast-bottom-right";
    toastr.options.positionClass = "toast-bottom-left";
    toastr.options.positionClass = "toast-top-right";
    toastr.options.positionClass = "toast-top-left";
    toastr.options.positionClass = "toast-bottom-full-width";
    toastr.options.positionClass = "toast-top-full-width";
    options = {
        tapToDismiss: true,
        toastClass: 'toast',
        containerId: 'toast-container',
        debug: false,
        fadeIn: 300,
        fadeOut: 1000,
        extendedTimeOut: 1000,
        iconClass: 'toast-info',
        positionClass: 'toast-top-right',
        timeOut: 5000, // Set timeOut to 0 to make it sticky
        titleClass: 'toast-title',
        messageClass: 'toast-message'
    }


    if (clear == true) {
        toastr.clear();
    }
    if (sticky == true) {
        toastr.tapToDismiss = true;
        toastr.timeOut = 5000;
    }

    toastr.options.onclick = function () {
        //alert('You can perform some custom action after a toast goes away');
    }
    //"toast-top-left";
    toastr.options.positionClass = pos;
    if (type.toLowerCase() == 'info') {
        toastr.options.timeOut = 1000;
        toastr.tapToDismiss = true;
        toastr.info(msg, title);
    }
    if (type.toLowerCase() == 'success') {
        toastr.options.timeOut = 1500;
        toastr.success(msg, title);
    }
    if (type.toLowerCase() == 'warning') {
        toastr.options.timeOut = 3000;
        toastr.warning(msg, title);
    }
    if (type.toLowerCase() == 'error') {
        toastr.options.timeOut = 10000;
        toastr.error(msg, title);
    }
}
function ConfermaOperazione(Testo, ID, Index) {
    swal({
        title: 'Confermi l\'operazione?',
        text: Testo,
        type: 'warning',
        showCancelButton: true,
        confirmButtonClass: 'btn btn-success',
        cancelButtonClass: 'btn btn-danger',
        confirmButtonText: 'INVIA',
        buttonsStyling: false,
        cancelButtonText: 'ANNULLA',
    }).then(function (isConfirm) {
        if (isConfirm) {
            var CallbackDaFarPartire = eval(ID);
            CallbackDaFarPartire.PerformCallback(Index);
            Testo = '';
            ID = '';
            Index = 0;
        }
    });
}
function setCookie(valore, path) {
    if (path == undefined) {
        path = "/";
    } var d = new Date();
    d.setTime(d.getTime() + (12000 * 24 * 60 * 60 * 1000));
    var expires = "expires=" + d.toUTCString();
    document.cookie = "LanguageGomsilIntra=" + valore + "; expires=" + expires + " ; path=" + path;
    location.reload();
    // alert(expires);
    leggi();
}

function getCookie(nome) {
    var name = nome + "=";
    var ca = document.cookie.split(';');
    for (var i = 0; i < ca.length; i++) {
        var c = ca[i];
        while (c.charAt(0) == ' ')
            c = c.substring(1);
        if (c.indexOf(name) == 0) return c.substring(name.length, c.length);
    }
    return "";
}
