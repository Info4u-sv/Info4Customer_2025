const qrcode1 = window.qrcode;

const video = document.createElement("video");
const canvasElement = document.getElementById("qr-canvas");
const canvas = canvasElement.getContext("2d");
const btnScanQR = document.getElementById("TastoQrCode_Btn");

let scanning = false;

qrcode1.callback = res => {
    if (res) {
        scanning = false;
        video.srcObject.getTracks().forEach(track => {
            track.stop();
        });
        canvasElement.hidden = true;
        btnScanQR.hidden = false;
        Accesso_Callbackpnl.PerformCallback(res);
    }
};

btnScanQR.onclick = () => {
    navigator.mediaDevices
        .getUserMedia({ video: { facingMode: "environment" } })
        .then(function (stream) {
            scanning = true;
            btnScanQR.hidden = true;
            canvasElement.hidden = false;
            video.setAttribute("playsinline", true); // required to tell iOS safari we don't want fullscreen
            video.srcObject = stream;
            video.play();
            tick();
            scan();
        });
};

function tick() {
    canvasElement.height = video.videoHeight;
    canvasElement.width = video.videoWidth;
    canvas.drawImage(video, 0, 0, canvasElement.width, canvasElement.height);

    scanning && requestAnimationFrame(tick);
}

function scan() {
    try {
        qrcode1.decode();
    } catch (e) {
        setTimeout(scan, 300);
    }
}
